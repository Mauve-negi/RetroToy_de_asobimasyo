class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #フォロー/フォロワ
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: :followed_id, class_name: "Relationship", dependent: :destroy
  has_many :follower_users, through: :reverse_relationships, source: :follower
  #フォロー/フォロワ

  #おなまえバリデーション
  validates :nickname, uniqueness: false, length: { minimum: 1, maximum: 20 }
  # validates :introduction, length: { maximum: 50 }


  enum play_ground_1: {
      no_pg1: 0, hokkaido_pg1: 1, aomori_pg1: 2,iwate_pg1: 3,miyagi_pg1: 4,akita_pg1: 5,yamagata_pg1: 6,fukushima_pg1: 7,
      ibaraki_pg1: 8,tochigi_pg1: 9,gunnma_pg1: 10,saitama_pg1: 11,chiba_pg1: 12,tokyo_pg1: 13,kanagawa_pg1: 14,
      niigata_pg1: 15,toyama_pg1: 16,ishikawa_pg1: 17,fukui_pg1: 18,yamanashi_pg1: 19,nagano_pg1: 20,
      gifu_pg1: 21,shizuoka_pg1: 22,aichi_pg1: 23,mie_pg1: 24,
      shiga_pg1: 25,kyoto_pg1: 26,oosaka_pg1: 27,hyougo_pg1: 28,nara_pg1: 29,wakayama_pg1: 30,
      tottori_pg1: 31,shimane_pg1: 32,okayama_pg1: 33,hiroshima_pg1: 34,yamaguchi_pg1: 35,
      tokushima_pg1: 36,kagawa_pg1: 37,ehime_pg1: 38,kouchi_pg1: 39,
      fukuoka_pg1: 40,saga_pg1: 41,nagasaki_pg1: 42,kumamoto_pg1: 43,ooita_pg1: 44,miyagi_pg1: 45,kagoshima_pg1: 46,okinawa_pg1: 47
    }
    
  enum play_ground_2: {
      no_pg2: 0, hokkaido_pg2: 1, aomori_pg2: 2,iwate_pg2: 3,miyagi_pg2: 4,akita_pg2: 5,yamagata_pg2: 6,fukushima_pg2: 7,
      ibaraki_pg2: 8,tochigi_pg2: 9,gunnma_pg2: 10,saitama_pg2: 11,chiba_pg2: 12,tokyo_pg2: 13,kanagawa_pg2: 14,
      niigata_pg2: 15,toyama_pg2: 16,ishikawa_pg2: 17,fukui_pg2: 18,yamanashi_pg2: 19,nagano_pg2: 20,
      gifu_pg2: 21,shizuoka_pg2: 22,aichi_pg2: 23,mie_pg2: 24,
      shiga_pg2: 25,kyoto_pg2: 26,oosaka_pg2: 27,hyougo_pg2: 28,nara_pg2: 29,wakayama_pg2: 30,
      tottori_pg2: 31,shimane_pg2: 32,okayama_pg2: 33,hiroshima_pg2: 34,yamaguchi_pg2: 35,
      tokushima_pg2: 36,kagawa_pg2: 37,ehime_pg2: 38,kouchi_pg2: 39,
      fukuoka_pg2: 40,saga_pg2: 41,nagasaki_pg2: 42,kumamoto_pg2: 43,ooita_pg2: 44,miyagi_pg2: 45,kagoshima_pg2: 46,okinawa_pg2: 47
    }
    
  enum play_ground_3: {
      no_pg3: 0, hokkaido_pg3: 1, aomori_pg3: 2,iwate_pg3: 3,miyagi_pg3: 4,akita_pg3: 5,yamagata_pg3: 6,fukushima_pg3: 7,
      ibaraki_pg3: 8,tochigi_pg3: 9,gunnma_pg3: 10,saitama_pg3: 11,chiba_pg3: 12,tokyo_pg3: 13,kanagawa_pg3: 14,
      niigata_pg3: 15,toyama_pg3: 16,ishikawa_pg3: 17,fukui_pg3: 18,yamanashi_pg3: 19,nagano_pg3: 20,
      gifu_pg3: 21,shizuoka_pg3: 22,aichi_pg3: 23,mie_pg3: 24,
      shiga_pg3: 25,kyoto_pg3: 26,oosaka_pg3: 27,hyougo_pg3: 28,nara_pg3: 29,wakayama_pg3: 30,
      tottori_pg3: 31,shimane_pg3: 32,okayama_pg3: 33,hiroshima_pg3: 34,yamaguchi_pg3: 35,
      tokushima_pg3: 36,kagawa_pg3: 37,ehime_pg3: 38,kouchi_pg3: 39,
      fukuoka_pg3: 40,saga_pg3: 41,nagasaki_pg3: 42,kumamoto_pg3: 43,ooita_pg3: 44,miyagi_pg3: 45,kagoshima_pg3: 46,okinawa_pg3: 47
    }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #フォロー/フォロワ
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  # def following?(user)
  #   followings.include?(user)
  # end
  def following?(user)
    followed_users.include?(user)
  end
  #フォロー/フォロワ

end