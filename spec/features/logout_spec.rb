require 'rails_helper'

RSpec.describe "Logging Out" do
  it "can log out a user" do
    user = User.create(name: "NicoShantii", email: "Email123@yahoo.com", password: "noneyourbusiness", password_confirmation: "noneyourbusiness")
    visit root_path
    click_on "Log In"
    
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on "Log In"

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_link("Logout")

    click_on("Logout")
    expect(current_path).to eq(root_path)
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end
end