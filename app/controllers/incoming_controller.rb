class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!

  def create

       @user = User.find_by_email(params[:sender])
       @topic = Topic.find_by_title(params[:subject])
       @url = params["body-plain"]

   if @user.nil?
       @user = User.new(
       email: params[:sender],
       password: params[:sender],
       password_confirmation: params[:sender]
      )
      @user.save!
    end

     if @topic.nil?
         @topic = @user.topics.build(title: params[:subject])
         @topic.save!
     end

       @bookmark = @topic.bookmarks.build(url: @url)
       @bookmark.save


    head 200
  end
end
