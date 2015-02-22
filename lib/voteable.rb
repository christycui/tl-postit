module Voteable
  # class methods
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :voteable
  end

  # instance methods
  def total_votes
    upvotes - downvotes
  end

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end
end