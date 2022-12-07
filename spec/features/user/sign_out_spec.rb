require "rails_helper"

feature "User can sign out", %q{
  In order to stop working with the system
  As an Authenticated user
  I'd like to be able to sign out
} do
  given(:user) { create(:user) }

  background { visit root_path }

  scenario "Registered user tries to sign in" do
    sign_in(user)
    click_on "Log out"

    expect(page).to have_content "Signed out successfully."
  end

  scenario "Unregistered user tries to sign in" do
    expect(page).to_not have_content "Log out"
  end
end
