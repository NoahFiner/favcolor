class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
        flash[:neutral] = "Please log in to access that page."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to user_path(current_user)
        flash[:danger] = "Wrong user for that page."
      end
    end

    def admin_user
      if !current_user.nil?
        unless current_user.admin?
          redirect_to users_url
          flash[:danger] = "Only admins can access that page."
        end
      else
        redirect_to login_url
        flash[:danger] = "Please log in to access that page."
      end
    end
end
