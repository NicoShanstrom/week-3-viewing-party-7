class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @logged_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
# so if @logged_in_user is nil, then it goes to user.find... IF a user_id session has initiated,
# otherwise the whole expression is nil

# The ||= operator is a shorthand for memoization. 
  # It means "assign the value to the variable if the variable is currently nil or false."
# The expression User.find(session[:user_id]) is only executed if @session_user is nil or undefined.
# The if session[:user_id] part ensures that User.find(session[:user_id]) is only called if session[:user_id] is present
#  If session[:user_id] is nil, the whole expression returns nil.
