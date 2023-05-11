class Post < ApplicationRecord
  has_one_attached :image #ActiveStrageで画像を持たせる
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true,length: {maximum: 1000 }

end
