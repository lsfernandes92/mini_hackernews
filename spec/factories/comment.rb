FactoryBot.define do
  factory :comment do
    body { 'This is some random comment' }
    commentable { create(:story) }
  end
end
