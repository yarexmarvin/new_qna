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
    scenario "edits a question with an attached file" do
      within ".question" do
        click_on "Edit Question"

        fill_in "Title", with: "Test question"
        fill_in "Body", with: "text text text"
        attach_file "File", ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on "Save"
      end
      expect(page).to have_link "rails_helper.rb"
      expect(page).to have_link "spec_helper.rb"
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
