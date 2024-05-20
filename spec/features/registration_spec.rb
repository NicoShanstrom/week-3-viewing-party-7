require 'rails_helper'

RSpec.describe "User Registration" do
  describe 'US1/challenge - can register a new user' do
    it 'can create a user with a name, password, unique email' do
      visit register_path

      fill_in :user_name, with: 'User One'
      fill_in :user_email, with:'user1@example.com'
      # save_and_open_page 
      fill_in :user_password, with:'itsasecret'
      fill_in :user_password_confirmation, with:'itsasecret'

      click_button 'Create New User'
      
      expect(current_path).to eq(user_path(User.last.id))
      expect(page).to have_content("User One's Dashboard")
      expect(page).to have_content("Welcome, #{User.last.name}!")
    end
  end 


    it 'does not create a user if email isnt unique' do 
      User.create(name: 'User One', email: 'notunique@example.com', password: 'password', password_confirmation: 'password')

      visit register_path
      
      fill_in :user_name, with: 'User Two'
      fill_in :user_email, with:'notunique@example.com'
      fill_in :user_password, with:'secretpassword'
      fill_in :user_password_confirmation, with:'secretpassword'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email has already been taken")
    end

    it 'does not create a user if user does not enter any of the form attributes' do 
      User.create(name: 'User One', email: 'notunique@example.com', password: 'password', password_confirmation: 'password')

      visit register_path
      
      fill_in :user_name, with: 'User Two'
      fill_in :user_email, with:''
      fill_in :user_password, with:'secretpassword'
      fill_in :user_password_confirmation, with:''
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email can't be blank and Password confirmation doesn't match Password")
    end
end
