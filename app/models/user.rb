class User < ActiveRecord::Base
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validate :password_complexity
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/
    errors.add :password, ' must have the following requirements: password must be at least 8 character, with a capital letter, a number, and a special character'
  end 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end