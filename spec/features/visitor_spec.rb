require 'rails_helper'

RSpec.describe "Visitor" do
  it "shows limited info on landing page if not logged in" do
    visit root_path
    expect(page).to have_button("Create New User")
    expect(page).to have_link("Log In")
    expect(page).to_not have_css(".existing-users")
  end

  it "cannot navigate to any pages other than root_path while not logged in" do
    user2 = User.create(name: "Wolf", email: "Wolfie@yahoo.com", password: "truck", password_confirmation: "truck")
    visit root_path
    visit user_path(user2)
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in or registered to access a user's dashboard")
  end
end