require 'rails_helper'

RSpec.feature 'Comment', type: :feature do
  before { create(:story) }

  let(:story) { Story.last }

  scenario 'displays the root story link' do
    visit(story_path(story))

    expect(page).to have_link("#{story.title}")
  end

  scenario 'submits comment to story' do
    visit(story_path(story))
    add_comment

    expect(page).to have_current_path(story_path(story))
    expect(page).to have_content('Your comment was successfully posted!')
    expect(page).to have_content('I am just posting for fun')
  end

  scenario 'submits a nested comment' do
    story.comments << create(:comment)

    visit(story_path(story))
    click_link('reply')
    add_comment('I am just posting a nested comment')

    expect(page).to have_current_path(story_path(story))
    expect(page).to have_content('Your comment was successfully posted!')
    expect(page).to have_xpath(
      "/html/body/div/div/ul/li/ul/div/li",
      text: 'I am just posting a nested comment'
    )
  end

  private

  def add_comment(comment = 'I am just posting for fun')
    fill_in('comment_body', with: comment)
    click_on('Add comment')
  end
end
