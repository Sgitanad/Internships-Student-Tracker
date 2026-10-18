<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Message;
use App\Models\User;

class MessageController extends Controller
{
    public function conversations()
    {
        $user = Auth::user();
        $userIds = collect();

        // Always include anyone they've exchanged messages with
        $messages = Message::where('sender_id', $user->id)
            ->orWhere('receiver_id', $user->id)
            ->get();

        foreach ($messages as $m) {
            $userIds->push($m->sender_id === $user->id ? $m->receiver_id : $m->sender_id);
        }

        // Etudiant: include their supervisor if assigned
        if ($user->role === 'ETUDIANT' && $user->encadrant_id) {
            $userIds->push($user->encadrant_id);
        }

        // Encadrant: include all students they supervise (even if no messages yet)
        if ($user->role === 'ENCADRANT') {
            $students = User::where('encadrant_id', $user->id)->pluck('id');
            foreach ($students as $sid) {
                $userIds->push($sid);
            }
        }

        $userIds = $userIds->unique()->values();

        $conversations = $userIds->map(function ($otherId) use ($user) {
            $other = User::find($otherId);
            if (!$other) return null;

            $lastMessage = Message::where('sender_id', $user->id)
                ->where('receiver_id', $otherId)
                ->latest()
                ->first()
                ?? Message::where('sender_id', $otherId)
                ->where('receiver_id', $user->id)
                ->latest()
                ->first();

            $unread = Message::where('sender_id', $otherId)
                ->where('receiver_id', $user->id)
                ->where('is_read', false)
                ->count();

            return [
                'id'           => $otherId,
                'other_user'   => $other,
                'last_message' => $lastMessage?->content ?? 'No messages yet',
                'unread'       => $unread,
            ];
        })->filter()->values();

        return response()->json(['conversations' => $conversations]);
    }

    public function messages($otherId)
    {
        $user = Auth::user();

        $messages = Message::where(function ($q) use ($user, $otherId) {
            $q->where('sender_id', $user->id)->where('receiver_id', $otherId);
        })->orWhere(function ($q) use ($user, $otherId) {
            $q->where('sender_id', $otherId)->where('receiver_id', $user->id);
        })->orderBy('created_at', 'asc')->get();

        Message::where('sender_id', $otherId)
            ->where('receiver_id', $user->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return response()->json(['messages' => $messages]);
    }

    public function send(Request $request, $otherId)
    {
        $request->validate([
            'content' => 'required|string|max:2000',
        ]);

        $user = Auth::user();

        if (!$user) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        \Log::info('Message send attempt', [
            'user_id' => $user->id,
            'receiver_id' => (int) $otherId,
            'content' => $request->content,
        ]);

        try {
            $message = Message::create([
                'sender_id'   => $user->id,
                'receiver_id' => (int) $otherId,
                'content'     => $request->content,
                'is_read'     => false,
            ]);
        } catch (\Exception $e) {
            \Log::error('Message save failed: ' . $e->getMessage());
            throw $e;
        }

        return response()->json(['message' => $message], 201);
    }
}