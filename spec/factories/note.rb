FactoryBot.define do
  factory :note do
    title { SecureRandom.alphanumeric }
    content { SecureRandom.alphanumeric }
  end
end