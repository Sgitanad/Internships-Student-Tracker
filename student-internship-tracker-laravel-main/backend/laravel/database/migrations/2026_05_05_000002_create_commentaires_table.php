<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('commentaires')) {
            return;
        }

        Schema::create('commentaires', function (Blueprint $table) {
            $table->id();
            $table->text('contenu')->nullable();
            $table->dateTime('date_creation', 6)->nullable();
            $table->foreignId('auteur_id')->nullable()->constrained('users');
            $table->foreignId('rapport_id')->nullable()->constrained('rapports');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('commentaires');
    }
};
