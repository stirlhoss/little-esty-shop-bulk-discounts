class GithubService < BaseService
  def self.get_repo_data
    response = conn('https://api.github.com').get('/repos/bwbolt/little-esty-shop')
    get_json(response)
  end

  # def self.get_pull_data
  #   response = conn('https://api.github.com').get('/repos/bwbolt/little-esty-shop/pulls')
  #   get_json(response)
  # end

  def self.conn(url)
    Faraday.new(url)
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
