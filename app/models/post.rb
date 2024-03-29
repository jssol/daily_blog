class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User'

  after_save :update_posts_counter

  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def latest_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    User.increment_counter(:posts_counter, author_id)
  end
end
