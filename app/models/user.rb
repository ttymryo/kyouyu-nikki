class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:email, :name_id]

  validates :name, presence: true
  validates :name_id, presence: true, uniqueness: true, length: { minimum: 3 }, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :introduction, length: { maximum: 255 }
  validates :is_public, inclusion: {in: [true, false]}
  validates :is_deleted, inclusion: {in: [true, false]}

  has_one_attached :image

  validates :image, file_content_type: { allow: /^image\/.*/ }


  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activity, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(gravity: :center, resize: "#{width}x#{height}^" , crop:"#{width}x#{height}+0+0").processed
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def follower?(user)
    follower_user.include?(user)
  end

  def ff?(user)
    following?(user) && follower?(user)
  end

  def self.guest
    find_or_create_by!(
      name: 'ゲストユーザー' ,
      name_id: 'guest_user',
      introduction: 'このアカウントは共用アカウントです。すべての機能が利用できます。プロフィールの設定は保存されません。' ,
      email: 'guest_user@example.com'
      ) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name_id = "guest_user"
    end
  end

  def self.looks(word)
    @user = []
    @user << User.where('name LIKE?', "%#{word}%")
    @user << User.where('name_id LIKE?', "%#{word}%")
    @user.flatten!
    @user.uniq!
    return @user
  end

end
