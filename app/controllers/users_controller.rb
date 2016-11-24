class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      not_found
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".signup_fail"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :user_name, :email, :password
  end
end
