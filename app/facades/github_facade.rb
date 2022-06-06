class GithubFacade
  def self.git_repo
    repo = GithubService.find_repo
    Repo.new(repo)
  end
end
