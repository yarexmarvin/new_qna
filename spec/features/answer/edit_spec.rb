require "rails_helper"

feature "User can edit his answer", %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe "Authenticated user", js: true do
    scenario "edits his answer" do
      sign_in(user)
      visit question_path(question)

      within ".answers" do
        click_on "Edit"

        fill_in "Body", with: "Updated Body"
        click_on "Save"

        expect(page).to_not have_content answer.body
        expect(page).to have_content "Updated Body"
        expect(page).to_not have_selector "textarea"
      end
    end
    scenario "edits his answer with error" do

    end
    scenario "tries to edit other user's answer" do
      
    end
  end

  scenario "Unanthenticated user can not edit answer" do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end
end
