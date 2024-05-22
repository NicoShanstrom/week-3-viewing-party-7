class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"

      cookies.encrypted[:location] = { 
        value: params[:location],
        expires: 3.months.from_now
      }

      if user.admin?
        redirect_to admin_dashboard_path and return
      elsif user.manager?
        redirect_to user_path(user) and return
      else
        redirect_to user_path(user) and return
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    successful_logout_redirect
  end
end