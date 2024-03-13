# frozen_string_literal: true


class FetchNotesJob
  @queue = :fetch_notes_queue

  def self.perform
    json_data = File.read(Rails.root.join('public/mock_data/note_templates.json'))
    notes_from_api = JSON.parse(json_data)

    notes_from_api.each do |note_data|
      existing_note = Note.find_by(title: note_data["title"])

      if existing_note.nil?
        # If no note with the same title exists, create a new one
        Note.create!(title: note_data["title"], content: note_data["content"])
      elsif existing_note.content != note_data["content"]
        # If a note with the same title exists and its content is different, update it
        existing_note.update(content: note_data["content"])
      end
    end

    puts "Notes fetched and updated successfully."
  end
end
