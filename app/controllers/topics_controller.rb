class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save!
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error creating the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "The topic was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :user)
  end
end
