<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('notifications')) {
            return;
        }

        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->dateTime('date_envoi', 6)->nullable();
            $table->boolean('est_lue')->default(false);
            $table->string('message')->nullable();
            $table->string('titre')->nullable();
            $table->foreignId('deadline_id')->nullable()->constrained('deadlines');
            $table->foreignId('rapport_id')->nullable()->constrained('rapports');
            $table->foreignId('user_id')->nullable()->constrained('users');
            $table->string('type', 191)->nullable()->default('general');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
