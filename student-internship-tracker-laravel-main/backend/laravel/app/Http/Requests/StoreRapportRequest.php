<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreRapportRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        // Only ETUDIANT can create rapports
        return auth()->check() && auth()->user()->role === 'ETUDIANT';
    }

    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'titre' => 'required|string|max:255',
            'fichier' => 'required|mimes:pdf,doc,docx|max:10240',
        ];
    }

    /**
     * Get custom messages for validator errors.
     */
    public function messages(): array
    {
        return [
            'titre.required' => 'The title is required.',
            'titre.max' => 'The title must not exceed 255 characters.',
            'fichier.required' => 'A PDF or Word file is required.',
            'fichier.mimes' => 'Only PDF and Word files are allowed.',
            'fichier.max' => 'The file must not exceed 10MB.',
        ];
    }

    /**
     * Get the error messages for failed authorization.
     */
    protected function failedAuthorization()
    {
        abort(403, 'Only students can create rapports.');
    }
}
