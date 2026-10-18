<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Only run if notifications table exists
        if (Schema::hasTable('notifications')) {
            DB::statement("ALTER TABLE notifications ADD COLUMN IF NOT EXISTS `type` varchar(191) DEFAULT 'general' AFTER `user_id`");
            DB::statement("ALTER TABLE notifications ADD COLUMN IF NOT EXISTS `rapport_id` bigint UNSIGNED NULL AFTER `type`");
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};