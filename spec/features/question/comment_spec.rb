require 'rails_helper'

feature 'User can comment a question', %q{
  In order to get more information about question
  As an authenticated user
  I'd like to be able to comment
} do

  given(:user) { create :user }
  given!(:question) { create :question, user: user }

  describe 'Not authorized user' do
    scenario "can't comment" do
      visit question_path(question)

      expect(page).to_not have_selector '.new-comment'
    end
  end

  describe 'authorized user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can add comment' do
      #save_and_open_page
      within '.question .comments-form' do
        fill_in 'Comment text', with: 'Test comment'
        click_on 'Comment'
      end

      expect(page).to have_content 'Test comment'
    end
  end

  describe 'Multiple sessions', js: true do
    scenario "comments appear on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        within '.question .comments-form' do
          fill_in 'Comment text', with: 'Test comment'
          click_on 'Comment'
        end

        expect(page).to have_content 'Test comment'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Test comment'
      end
    end
  end
end