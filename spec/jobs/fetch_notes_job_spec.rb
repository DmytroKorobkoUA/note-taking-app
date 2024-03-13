# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchNotesJob, type: :job do
  describe '#perform' do
    let(:json_data) { '[{"title": "Note 1", "content": "Content 1"}, {"title": "Note 2", "content": "Content 2"}]' }

    before do
      allow(File).to receive(:read).with(Rails.root.join('public/mock_data/note_templates.json')).and_return(json_data)
    end

    context 'when there are no existing notes' do
      it 'creates new notes from the mock data' do
        expect {
          FetchNotesJob.perform
        }.to change { Note.count }.by(2)
      end
    end

    context 'when existing notes have the same title' do
      before do
        create(:note, title: 'Note 1', content: 'Old Content')
      end

      it 'updates existing notes with different content' do
        expect {
          FetchNotesJob.perform
        }.to change { Note.find_by(title: 'Note 1').content }.to('Content 1')
      end
    end

    it 'prints success message' do
      expect { FetchNotesJob.perform }.to output("Notes fetched and updated successfully.\n").to_stdout
    end
  end
end
