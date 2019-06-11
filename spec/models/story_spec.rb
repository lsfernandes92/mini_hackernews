require 'rails_helper'

RSpec.describe Story, type: :model do
  subject { described_class.new(attributes_for(:story)) }

  context 'when is being creating' do
    it 'succeds with valid attributes' do
      expect(subject).to be_valid
      expect{ subject.save }.to change{ Story.all.count }.by(1)
    end

    context 'with invalid attributes' do
      it 'validates title presence' do
        subject.title = ''
        subject.save

        expect(subject.errors.full_messages).to match_array(
          ["Title can't be blank"]
        )
      end

      it 'validates title maximum 110 length' do
        subject.title = "a" * 111
        subject.save

        expect(subject.errors.full_messages).to match_array(
          ["Title is too long (maximum is 110 characters)"]
        )
      end

      it 'validates url presence' do
        subject.url = ''
        subject.save

        expect(subject.errors.full_messages).to match_array(
          ["Url can't be blank"]
        )
      end
    end
  end
end
