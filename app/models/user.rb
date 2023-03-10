class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_one_attached :avatar

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false}
  validates_format_of :name, with: /^[a-zA-Z0-9_¥.]*$/, multiline: true
  validate :validate_name

  has_many :posts, inverse_of: :user

  def validate_name
    errors.add(:name, :invalid) if User.where(email: name).exists?
  end
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email]&.downcase!
    login = conditions.delete(:login)
    where(conditions.to_hash).where(
      ["lower(name) = :value or lower(email) = :value",
       { value: login.downcase }]
    ).first
  end

  def created_month
    created_at.strftime('%Y年%m月')
  end
end
