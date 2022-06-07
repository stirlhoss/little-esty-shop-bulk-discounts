require 'rails_helper'
require './app/services/github_service'

RSpec.describe GithubService do
  describe "repo endpoint" do
    it "gets repo data from endpoint" do
      json = GithubService.get_repo_data
      expect(json).to have_key(:name)
    end
  end
end
