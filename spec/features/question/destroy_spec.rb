require "rails_helper"

feature "User can delete a question", %q{
  In order to get rid of wrong question,
  As authenticated user,
  And as an author of a particular question,
  I'd like to delete a question
} do
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user1) }

  describe "Authenticated user" do
    scenario "delete his question" do
      sign_in(user1)
      visit question_path(question)
      click_on "Delete"

      expect(page).to_not have_content question.title
      expect(page).to have_content "Your question successfully deleted"
    end

    scenario "tries to delete questions from other people" do
      sign_in(user2)
      visit question_path(question)

      expect(page).to_not have_content "Delete"
    end
  end

  scenario "Unauthenticated user tries to delete any question" do
    visit question_path(question)

    expect(page).to_not have_content "Delete"
  end
end