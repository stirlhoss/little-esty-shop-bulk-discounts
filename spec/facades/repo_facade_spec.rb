require 'rails_helper'

RSpec.describe RepositoryFacade do
  it "creates repo poros" do
    repo = RepositoryFacade.create_repo
    expect(repo).to be_a(Repository)
  end
end
