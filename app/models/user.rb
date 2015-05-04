class User < ActiveRecord::Base

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

end
