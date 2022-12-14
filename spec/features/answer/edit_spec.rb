require "rails_helper"

feature "User can edit his answer", %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe "Authenticated user", js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end
    scenario "edits his answer" do
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

      within ".answers" do
        click_on "Edit"
        fill_in "Body", with: ""
        click_on "Save"
      end

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario "tries to edit other user's answer" do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_content "Edit"
  end

  scenario "Unanthenticated user can not edit answer" do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end
end
