<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Notification;

class NotificationController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        // If notifications disabled for this user, do not return any items
        if (isset($user->notifications_enabled) && !$user->notifications_enabled) {
            return response()->json(['notifications' => []]);
        }

        $notifications = Notification::where('user_id', $user->id)
            ->orderBy('date_envoi', 'desc')
            ->take(20)
            ->get();

        return response()->json(['notifications' => $notifications]);
    }

    public function enabled()
    {
        $user = Auth::user();
        $enabled = true;
        if (isset($user->notifications_enabled)) {
            $enabled = (bool) $user->notifications_enabled;
        }

        return response()->json(['enabled' => $enabled]);
    }

    public function setEnabled(Request $request)
    {
        $user = Auth::user();

        $data = $request->validate([
            'enabled' => 'required|boolean',
        ]);

        $user->notifications_enabled = $data['enabled'];
        $user->save();

        return response()->json(['message' => 'Notification preference updated.']);
    }


    public function markAsRead($id)
    {
        $user = Auth::user();
        $notification = Notification::where('id', $id)
            ->where('user_id', $user->id)
            ->firstOrFail();

        $notification->update(['est_lue' => 1]);

        return response()->json(['message' => 'Marked as read.']);
    }

    public function markAllRead()
    {
        $user = Auth::user();
        Notification::where('user_id', $user->id)
            ->where('est_lue', 0)
            ->update(['est_lue' => 1]);

        return response()->json(['message' => 'All marked as read.']);
    }
}