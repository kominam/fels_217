class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  before_action :logged_in_user
  layout :admin_layout

  def load_all_category
    @categories = Category.all
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 if @user.nil?
  end

  def admin_layout
    unless current_user.nil?
      current_user.is_admin? ? "admin" : "application"
    end
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "login_confirm"
      redirect_to login_path
    end
  end
end
