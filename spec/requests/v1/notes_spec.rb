# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::NotesController, type: :request do
  describe 'GET /v1/notes' do
    let!(:notes) { create_list(:note, 3) }

    context 'without search params' do
      it 'returns notes' do
        get v1_notes_path

        expect(response).to have_http_status(:ok)
        expect(json_response.count).to eq(3)
      end
    end

    context 'with search params' do
      let!(:needed_notes) { create_list(:note, 2, title: 'Testing note') }

      it 'returns needed notes' do
        get v1_notes_path, params: { search: 'Testing' }

        expect(response).to have_http_status(:ok)
        expect(json_response.count).to eq(2)
      end
    end
  end

  describe 'GET /v1/notes/:id' do
    let!(:note) { create :note }

    it 'returns note' do
      get v1_note_path(id: note.id)

      expect(response).to have_http_status(:ok)
      expect(json_response[:id]).to eq(note.id)
    end
  end
end
