require "rails_helper"

feature "User can see answers to a question", %q{
  In order to get a solution for the question
  I'd like to be able to see  answers of a question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario "Authenticated user can see answers to a question" do
    sign_in(user)
    visit question_path(answer.question)

    expect(page).to have_content "Question"
    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.body
    expect(page).to have_content answer.body
  end
  scenario "Unauthenticated user can see answers to a question" do
    visit question_path(answer.question)

    expect(page).to have_content "Question"
    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.body
    expect(page).to have_content answer.body
  end
end