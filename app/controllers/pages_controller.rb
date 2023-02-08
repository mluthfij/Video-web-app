class PagesController < ApplicationController
  def home
    cookies.delete(:moon)

    @users = User.all
  end
end
