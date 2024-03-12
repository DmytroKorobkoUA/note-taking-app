# frozen_string_literal: true
require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  has_many :notes, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
