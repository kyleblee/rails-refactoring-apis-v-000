class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubRepo.new({})
    session[:token] = github.secure_access_token(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    session[:username] = github.set_username(session["token"])

    redirect_to '/'
  end
end
