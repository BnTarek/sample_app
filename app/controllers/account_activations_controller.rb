class AccountActivationsController < ApplicationController

	def new
  end

  def create
    @user = User.find_by(email: params[:account_activation][:email].downcase)
    if @user && !@user.activated?
      @user.recreate_activation_digest
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    elsif @user && @user.activated?
      flash[:warning] = "Account already activated!"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
