require "rails_helper"

feature "User can create an answer for a question", %q{
  In order to help other users
  As an auhthenticated user
  I'd like to create an answer for a question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe "Authenticated user", js: true do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario "can create an answer" do
      fill_in "Body", with: "The answer on the question"
      click_on "Answer"

      expect(page).to have_content "The answer on the question"
    end

    scenario "tries create an answer with errors" do
      click_on "Answer"
      
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario "Unauthenticated user tries to answer a question" do
    visit question_path(question)

    expect(page).to_not have_content "Answer"
  end
end
