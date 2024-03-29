class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def latest_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end

  # User::Roles
  # The available roles
  ROLES = %i[admin normal].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
