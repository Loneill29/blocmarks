class BookmarksController < ApplicationController
before_action :authenticate_user!

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
    @bookmarks = @topic.bookmarks
    @bookmark.topic = @topic

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
end
