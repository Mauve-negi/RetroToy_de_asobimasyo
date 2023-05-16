class Post < ApplicationRecord
  has_one_attached :image #ActiveStrageで画像を持たせる
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true,length: {maximum: 1000 }

  # 投稿タイプ
  enum post_type: {
      nikki: 0, konoyubitomare: 1
    }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end