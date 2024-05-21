class WelcomeController < ApplicationController 
  def index 
    @users = User.all
    #plaintext cookie
    # unless cookies[:greeting]
    # cookies[:greeting] = "Hello There"
    # end

    #signed cookie
    # cookies.signed[:greeting] = "Hello There"

    #encrypted cookie
    # cookies.encrypted[:greeting] = "Hi"
    # cookies.delete :greeting
  end 
end 