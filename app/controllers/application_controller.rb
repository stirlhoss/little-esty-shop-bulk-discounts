class ApplicationController < ActionController::Base
  before_action :repo_info, only: %i[index show edit new]

  def repo_info
    @info = RepositoryFacade.create_repo
  end
end
