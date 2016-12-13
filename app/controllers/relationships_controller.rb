class RelationshipsController < ApplicationController
  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    current_user.activities.create action_type: Activity.actions[:follow],
      target_id: @user.id
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end

  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    current_user.activities.create action_type: Activity.actions[:unfollow],
      target_id: @user.id
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
