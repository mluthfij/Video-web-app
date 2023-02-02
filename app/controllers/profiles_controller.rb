class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find_by_id(params[:id])
    @videos = @user.videos.all
  end
  def show_profile
    @user = User.find_by_id(params[:id])
    @videos = @user.videos.all    
  end
end
