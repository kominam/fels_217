class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]

  def index
    @users = User.search_name(params[:q])
      .paginate page: params[:page]
  end

  def show
    @user = User.find_by id: params[:id]
    render_404 if @user.nil?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if current_user.nil?
      if @user.save
        log_in @user
        flash[:success] = t ".signup_success"
        redirect_to @user
      else
        flash.now[:danger] = t ".signup_fail"
        render :new
      end
    else
      flash.now[:danger] = t ".logout"
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
    render_404 if @user.nil?
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t(".profile")
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :user_name, :email, :password,
      :password_confirmation
  end
end
