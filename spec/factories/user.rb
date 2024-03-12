FactoryBot.define do
  factory :user do
    username { SecureRandom.alphanumeric }
    password { 'StrongPassword' }
    password_confirmation { 'StrongPassword' }
  end
end