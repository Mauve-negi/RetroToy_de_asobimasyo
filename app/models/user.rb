class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  
  validates :nickname, uniqueness: false, length: { minimum: 1, maximum: 20 }
  # validates :introduction, length: { maximum: 50 }

  enum play_ground_1: { no_pg1: 0, tokyo_pg1: 1, saitama_pg1: 2 }
  enum play_ground_2: { no_pg2: 0, tokyo_pg2: 1, saitama_pg2: 2 }
  enum play_ground_3: { no_pg3: 0, tokyo_pg3: 1, saitama_pg3: 2 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
