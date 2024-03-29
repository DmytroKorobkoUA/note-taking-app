# frozen_string_literal: true

class Note < ApplicationRecord
 validates :title, :content, presence: true

  def self.search(query)
    if query.present?
      where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    else
      all
    end
  end
end
