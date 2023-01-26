class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find_by_id(params[:id])
  end
end
