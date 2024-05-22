require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "NicoShantii", email: "Email123@yahoo.com", password: "noneyourbusiness", password_confirmation: "noneyourbusiness")

    visit root_path
    expect(page).to have_link("Log In", href: "/login")
    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "NicoShantii", email: "EMAIL123@yahoo.com", password: "noneyourbusiness", password_confirmation: "noneyourbusiness")
    
    visit root_path
    
    expect(page).to have_link("Log In", href: "/login")
    click_on "Log In"
    
    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: "nopassword"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it 'has a cookie location field on the login page, shows this cookie value on user_path(user), and keeps the value once a user logs out and back in' do
    user = User.create(name: "NicoShantii", email: "EMAIL123@yahoo.com", password: "noneyourbusiness", password_confirmation: "noneyourbusiness")
    
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: "Asheville, NC"

    click_on "Log In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Location: Asheville, NC")

    expect(page).to have_link("Logout", href: logout_path )
    click_on "Logout"

    visit login_path
   
    expect(find_field("location").value).to eq("Asheville, NC")
  end

  it 'Remembers a user upon successful log in/registration even if they leave the page and return' do
    user = User.create(name: "NicoShantii", email: "EMAIL123@yahoo.com", password: "noneyourbusiness", password_confirmation: "noneyourbusiness")
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: "Asheville, NC"

    click_on "Log In"
    expect(current_path).to eq(user_path(user))

    visit "https://www.google.com"
    
    visit root_path
    
    expect(page).to have_link("Logout")
  end
end