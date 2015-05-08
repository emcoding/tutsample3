class User < ActiveRecord::Base

  attr_accessor :remember_token

  #before_save { self.email = email.downcase }
  #Ch6 exerc 2: this method can be written using the bang! method:
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i Replaced by regex
  # which detects ..com format errors:
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            #  uniqueness: true changed to: [implicating true]:
            uniqueness: { case_sensitive: false}

  has_secure_password
  validates :password, length: { minimum: 6 }

  #Added in ch8.2.4 : adding a digest method for use in fixtures
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #ch8.4 Remember token [with attribute accessor and remember method]
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
