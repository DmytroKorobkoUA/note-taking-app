FactoryBot.define do
  factory :note do
    user

    title { SecureRandom.alphanumeric }
    content { SecureRandom.alphanumeric }
  end
end