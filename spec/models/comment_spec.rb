require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new(body: 'Some shit has been said') }

  context 'when is being creating' do
    it 'succeds with valid attributes' do
      expect(subject).to be_valid
      expect{ subject.save }.to change{ Comment.all.count }.by(1)
    end

    it 'validates body presence' do
      subject.body = ''
      subject.save

      expect(subject.errors.full_messages).to match_array(
        ["Body can't be blank"]
      )
    end
  end
end
