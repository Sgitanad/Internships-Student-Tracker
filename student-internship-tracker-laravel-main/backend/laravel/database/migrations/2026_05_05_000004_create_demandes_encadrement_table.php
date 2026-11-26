<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('demandes_encadrement')) {
            return;
        }

        Schema::create('demandes_encadrement', function (Blueprint $table) {
            $table->id();
            $table->dateTime('date_demande', 6)->nullable();
            $table->dateTime('date_reponse', 6)->nullable();
            $table->string('message')->nullable();
            $table->enum('statut', ['ACCEPTE', 'EN_ATTENTE', 'REFUSE'])->nullable();
            $table->foreignId('encadrant_id')->nullable()->constrained('users');
            $table->foreignId('etudiant_id')->nullable()->constrained('users');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('demandes_encadrement');
    }
};
