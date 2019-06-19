require 'rails_helper'

RSpec.feature 'Story', type: :feature do
  before { create(:story) }

  let(:story) { Story.last }

  context 'submit with correct infos' do
    scenario 'succeds with title and url filled in' do
      visit(root_url)

      click_link('submit')

      fill_in('Title', with: 'Some cool test that describe the story')
      fill_in('Url', with: 'http://coollink.com')
      click_on('Submit')

      expect(page).to have_current_path(root_url)
      expect(page).to have_content('Story submitted successfully!')
      expect(page).to have_content('Some cool test that describe the story')
    end
  end

  context 'submit with wrong infos' do
    scenario 'fails with title and url filled in' do
      visit(root_url)

      click_link('submit')
      click_on('Submit')

      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Url can't be blank")
    end

    scenario 'fails with title exceding 110 characters' do
      visit(root_url)

      click_link('submit')
      fill_in('Title', with: "a"*111)
      click_on('Submit')

      expect(page).to have_content("Title is too long (maximum is 110 characters)")
    end
  end

  context 'deleting story' do
    scenario 'succeds on confirm' do
      visit(root_url)

      expect(page).to have_content(story.title)
      expect{ click_link('delete') }.to change{ Story.count }.by(-1)
      expect(page).to have_content("Story deleted successfully!")
      expect(page).not_to have_content(story.title)
    end
  end

  scenario 'redirects to link when click on title' do
    visit(root_url)
    click_link(story.title)

    expect(page).to have_current_path(story.url)
  end
end
