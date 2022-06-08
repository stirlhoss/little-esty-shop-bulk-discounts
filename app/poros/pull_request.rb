class PullRequest

  attr_accessor :user,
                :id

  def initialize(pr_data)
    @user = pr_data[:user][:login]
    @id = pr_data[:id]
  end
end
