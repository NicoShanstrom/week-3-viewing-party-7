class UsersController <ApplicationController 

  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end

  def login_form
  end

  def login
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
      render :login_form
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 