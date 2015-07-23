class UsersController < ApplicationController
  # before_action :check_login, except: [:new, :create, :login, :login_confirm]


  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def new
    @user = User.new
    # Automatically load the view in /views/users/new.html.erb
  end

  # Processes the new-user form submission.
  def create
    @user = User.new(user_params_and_password)
    @user.encrypt_password(params[:password])
    if @user.save
      redirect_to user_path
    else
      render users_path
    end
  end

  def login
  end

  def login_confirm
    @user = User.find_by(email: params[:email])
    if @user.correct_password?(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path
    else
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to users_path
  end



  def edit
    @user = User.find(params[:id])
    # Automatically load the view in /views/users/edit.html.erb
    end

  # Processes the edit-user form submission.
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path # Redirection needs a request path.
    else
      # Rendering needs a specific view template to show.

      # erb :"users/edit" # That's Sinatra though.
      render edit_user_path # "users" folder is assumed.
    end
  end

  def show

    @user = User.find(params[:id])

  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end

  def user_params_and_password
    params.permit(:name, :email, :password)
  end

  def check_login
    if session[:user_id] == nil
      redirect_to new_user_path
    else
      @user = User.find(session[:user_id])
    end
  end

end
