class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      # redirect_to user_path(user)
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
end