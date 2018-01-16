class RepositoriesController < ApplicationController
  def index
    github = GithubRepo.new({})
    @repos_array = github.get_repos(session[:token])
  end

  def create
    github = GithubRepo.new({})
    github.create_repo(params[:name], session[:token])
    redirect_to '/'
  end
end
