# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { create :note }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end
end
