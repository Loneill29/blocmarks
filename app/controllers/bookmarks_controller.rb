class BookmarksController < ApplicationController
before_action :authenticate_user!
before_action :authorize_user, except: [:show, :new, :create]
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @topic = Topic.find(params[:topic_id])
    @bookmark.topic = @topic
    @bookmark.user = current_user

    if @bookmark.save!
      flash[:notice] = "Bookmark was saved."
      redirect_to @bookmark.topic
    else
      flash[:error] = "There was an error creating the bookmark. Please try again."
      render :new
    end
  end

  def update
  @bookmark = Bookmark.find(params[:id])

  @bookmark.url = params[:bookmark][:url]
  @bookmark.assign_attributes(bookmark_params)
  authorize @bookmark


  if @bookmark.save
    flash[:notice] = "Bookmark was updated."
    redirect_to @bookmark.topic
  else
    flash.now[:alert] = "Error saving bookmark. Please try again."
    render :edit
  end
end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "The bookmark was deleted successfully."
      redirect_to @bookmark.topic
    else
      flash[:error] = "There was an error deleting the bookmark."
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

  def authorize_user
  bookmark = Bookmark.find(params[:id])

  unless current_user == bookmark.user
    flash[:alert] = "You are not authorized to do that."
    redirect_to [bookmark.topic, bookmark]
  end
end
end
