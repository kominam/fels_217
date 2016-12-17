class FollowersController < ApplicationController
  before_action :load_user

  def show
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
