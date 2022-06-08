class GithubService
  def self.get_repo_data
    response = conn.get('/repos/bwbolt/little-esty-shop')
    parse(response)
  end

  def self.pulls
    response = conn.get('/repos/bwbolt/little-esty-shop/pulls?state=closed&per_page=100')
    parse(response)
  end

  private

  def self.conn
    Faraday.new('https://api.github.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
