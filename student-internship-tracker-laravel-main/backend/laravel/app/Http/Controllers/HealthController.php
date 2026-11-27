<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class HealthController
{
    public function __invoke(): JsonResponse
    {
        DB::select('select 1');

        return response()->json(['status' => 'ok']);
    }
}
