class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true

  enum role: {
    user: 0,
    vip_user: 1,
    platinum_user: 2,
    admin: 3
  }

  has_many :stories
  has_one_attached :avatar
  has_many :follows
  has_many :bookmarks

  def paid_user?
    vip_user? || platinum_user?
  end

  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Followed'
    end
  end

  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return "Unbookmarked"
    else
      bookmarks.create(story: story)
      return "Bookmarked"
    end
  end
end
