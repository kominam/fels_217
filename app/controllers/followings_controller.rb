class FollowingsController < ApplicationController
  before_action :load_user

  def show
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
