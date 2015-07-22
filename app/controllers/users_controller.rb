class UsersController < ApplicationController


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
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path # Redirection needs a request path.
    else
      # Rendering needs a specific view template to show.

      # erb :"users/new" # That's Sinatra though.
      render users_path # "users" folder is assumed.
    end
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

end
