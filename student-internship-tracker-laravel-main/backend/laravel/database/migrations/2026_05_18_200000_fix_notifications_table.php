<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('notifications')) {
            return;
        }

        if (! Schema::hasColumn('notifications', 'type')) {
            Schema::table('notifications', function (Blueprint $table) {
                $table->string('type', 191)->nullable()->default('general');
            });
        }

        if (! Schema::hasColumn('notifications', 'rapport_id')) {
            Schema::table('notifications', function (Blueprint $table) {
                $table->unsignedBigInteger('rapport_id')->nullable();
            });
        }
    }

    public function down(): void
    {
        //
    }
};
