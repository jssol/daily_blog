class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  after_save :update_posts_counter

  def latest_comments
    Comment.order(created_at: :desc).includes([:author]).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
