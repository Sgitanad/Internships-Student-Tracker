<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasColumn('users', 'name') && ! Schema::hasColumn('users', 'nom')) {
            Schema::table('users', function (Blueprint $table) {
                $table->renameColumn('name', 'nom');
            });
        }

        if (Schema::hasColumn('users', 'password') && ! Schema::hasColumn('users', 'mot_de_passe')) {
            Schema::table('users', function (Blueprint $table) {
                $table->renameColumn('password', 'mot_de_passe');
            });
        }

        if (! Schema::hasColumn('users', 'role')) {
            Schema::table('users', function (Blueprint $table) {
                $table->enum('role', ['ADMIN', 'ENCADRANT', 'ETUDIANT'])->nullable();
            });
        }

        if (! Schema::hasColumn('users', 'encadrant_id')) {
            Schema::table('users', function (Blueprint $table) {
                $table->foreignId('encadrant_id')->nullable()->constrained('users');
            });
        }
    }

    public function down(): void
    {
        //
    }
};
