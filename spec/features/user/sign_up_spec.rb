require "rails_helper"

feature "User can sign up", %q{
  In order to start working with the system
  I'd like to be able to sign up
} do
  given(:user) { create(:user) }

  background { visit new_user_registration_path }

  scenario "Registered user tries to sign in" do
    fill_in "Email", with: "user1@mail.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_on "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "Registered user tries to sign in" do
    fill_in "Email", with: user.email
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_on "Sign up"

    expect(page).to have_content "Email has already been taken"
  end

  scenario "Unregistered user tries to sign in" do
    fill_in "Email", with: "norm@test.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "123456738"
    click_on "Sign up"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
