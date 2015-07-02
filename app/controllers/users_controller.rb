class UsersController < ApplicationController
  before_filter :authorize_user, only: :new
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to Mallaky App!"
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

    def authorize_user
      if current_user
        flash[:danger] = "You are already logged in!"
        redirect_to root_path
      end
    end

end
