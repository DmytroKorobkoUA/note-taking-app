# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Users::NotesController, type: :request do
  describe 'POST /v1/users/notes' do
    let(:user) { create :user }
    let(:note_params) {{ title: 'New Title', content: 'New Note Content' }}

    context 'authorized' do
      it 'creates new note' do
        post login_v1_auth_path, params: { username: user.username, password: 'StrongPassword' }
        post v1_users_notes_path, params: note_params, headers: { 'Authorization' => "Bearer #{json_response[:token]}" }

        expect(response).to have_http_status(:ok)
        expect(Note.all.count).to eq(1)
      end
    end

    context 'unauthorized' do
      it 'returns unauthorized' do
        post v1_users_notes_path, params: note_params

        expect(response).to have_http_status(:unauthorized)
        expect(Note.all.count).to eq(0)
      end
    end
  end

  describe 'PATCH /v1/users/notes/:id' do
    let(:user) { create :user }
    let(:note) { create :note }
    let(:note_params) {{ title: 'Updated Title', content: 'Updated Note Content'}}

    context 'authorized' do
      it 'updates the note' do
        post login_v1_auth_path, params: { username: user.username, password: 'StrongPassword' }

        patch v1_users_note_path(id: note.id), params: note_params, headers: { 'Authorization' => "Bearer #{json_response[:token]}" }

        note.reload

        expect(response).to have_http_status(:ok)
        expect(note.title).to eq(note_params[:title])
        expect(note.content).to eq(note_params[:content])
      end
    end

    context 'unauthorized' do
      it 'returns unauthorized' do
        patch v1_users_note_path(id: note.id), params: note_params

        note.reload

        expect(response).to have_http_status(:unauthorized)
        expect(note.title).to_not eq(note_params[:title])
        expect(note.content).to_not eq(note_params[:content])
      end
    end
  end

  describe 'DELETE /v1/users/notes/:note_id/destroy' do
    let(:user) { create :user }
    let(:another_user) { create :user }
    let!(:note) { create :note }

    context 'authorized' do
      it 'removes the note' do
        post login_v1_auth_path, params: { username: user.username, password: 'StrongPassword' }

        delete v1_users_note_path(id: note.id), headers: { 'Authorization' => "Bearer #{json_response[:token]}" }

        expect(response).to have_http_status(:ok)
        expect(Note.all.count).to eq(0)
      end
    end

    context 'unauthorized' do
      it 'returns unauthorized' do
        delete v1_users_note_path(id: note.id)

        expect(response).to have_http_status(:unauthorized)
        expect(Note.all.count).to eq(1)
      end
    end
  end
end
