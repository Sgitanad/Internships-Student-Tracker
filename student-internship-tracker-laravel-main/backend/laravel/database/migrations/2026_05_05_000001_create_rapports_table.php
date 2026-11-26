<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('rapports')) {
            return;
        }

        Schema::create('rapports', function (Blueprint $table) {
            $table->id();
            $table->text('contenu')->nullable();
            $table->dateTime('date_depot', 6)->nullable();
            $table->string('statut')->nullable();
            $table->string('titre')->nullable();
            $table->foreignId('auteur_id')->nullable()->constrained('users');
            $table->foreignId('encadrant_id')->nullable()->constrained('users');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('rapports');
    }
};
