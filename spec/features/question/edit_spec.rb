require "rails_helper"

feature "User can edit his question", %q{
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe "Authenticated user", js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end
    scenario "edits his question" do
      within ".question" do
        click_on "Edit Question"

        fill_in "Title", with: "Updated Title"
        fill_in "Body", with: "Updated Body"
        click_on "Save"

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content "Updated Title"
        expect(page).to have_content "Updated Body"
        expect(page).to_not have_selector "textarea"
      end
    end
    scenario "edits his question with error" do
      within ".question" do
        click_on "Edit Question"
        fill_in "Title", with: ""
        fill_in "Body", with: ""
        click_on "Save"
      end

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario "tries to edit other user's question" do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_content "Edit Question"
  end

  scenario "Unanthenticated user can not edit question" do
    visit question_path(question)

    expect(page).to_not have_link "Edit Question"
  end
end
