# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  def self.search(query)
    if query.present?
      where("title LIKE :query OR content LIKE :query OR users.username LIKE :query", query: "%#{query}%").joins(:user)
    else
      all
    end
  end
end
