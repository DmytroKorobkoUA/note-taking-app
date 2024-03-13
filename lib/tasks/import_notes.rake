# frozen_string_literal: true

namespace :notes do
  desc "Import notes from JSON file"
  task import: :environment do
    json_data = File.read(Rails.root.join('public/mock_data/note_templates.json'))
    notes = JSON.parse(json_data)

    notes.each do |note_data|
      Note.create!(title: note_data["title"], content: note_data["content"])
    end

    puts "Notes imported successfully."
  end
end
