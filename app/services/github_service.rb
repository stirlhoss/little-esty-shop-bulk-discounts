class GithubService
  def self.connection
    url = "https://api.github.com/repos/bwbolt/little-esty-shop"
    Faraday.new(url: url)
  end

  def self.find_repo
    response = connection.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
