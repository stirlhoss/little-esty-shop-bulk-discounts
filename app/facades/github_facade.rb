class GithubFacade
  # def self.create_or_error_message
  #   json = GithubService.get_repo_data
  #   json[:message].nil? ? create_repo : json
  # end

  def self.create_repo
    json = GithubService.get_repo_data
    Repository.new(json)
  end

  # def self.number_of_pulls
    # pulls = GithubService.pulls
    # pulls.count
  # end

  def self.number_of_pulls
    pr_array = []
    pulls = GithubService.pulls
    pulls.each do |pr|
      pr_array << PullRequest.new(pr)
    end
    pr_array.count
  end
end
