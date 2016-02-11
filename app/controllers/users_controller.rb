class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      flash[:neutral] = "You're already logged in. Please logout to use this feature."
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to favicolor!"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
