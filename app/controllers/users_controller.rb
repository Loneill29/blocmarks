class UsersController < ApplicationController
  def show
      @user = current_user
      @user_bookmarks = @user.bookmarks
      @liked_bookmarks = @user.liked_bookmarks
    end
end
