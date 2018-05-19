class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'https://api.mailgun.net/v3/sandboxf31a46b63ca74b9fa8d4d43b9ebe3e1a.mailgun.org'
    mail(to: @user.email, subject: 'Welcome to Blocmarks!')
  end
end
