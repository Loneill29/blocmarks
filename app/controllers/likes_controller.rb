class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def index
   end

   def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     @topic = @bookmark.topic
     like = current_user.likes.build(bookmark: @bookmark)
     authorize like

     if like.save
       flash[:notice] = "Bookmark was liked."
     else
       flash.now[:alert] = "There was an error liking that bookmark. Please try again."
     end
     redirect_to @bookmark.topic
   end

   def destroy
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.likes.find(params[:id])
     @topic = @bookmark.topic
     authorize like

     if like.destroy
       flash[:notice] = "Bookmark was unliked."
     else
       flash.now[:alert] = "There was an error un-liking that bookmark. Please try again."
     end
     redirect_to @bookmark.topic
   end

   private

   def authorize_user
     like = current_user.likes.build(bookmark: @bookmark)

   unless current_user == like.user
     flash[:alert] = "You are not authorized to do that."
     redirect_to @bookmark.topic
   end
   end
 end
