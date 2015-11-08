class User < ActiveRecord::Base

  # password and password_confirmation attr_accessors are created by below
  # 'has_secure_password'
  # u = User.new(email: "blah@gmail.com")
  # u.password = "blah"
  # u.password_confirmation = "bldaah"
  # The 2 don't match so there will be an error attached to u.errors
  has_secure_password

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  # so that if a user closes their account the accounts are not deleted
  # instead the user_id in the question table is nullified

  validates :email, presence: true, uniqueness: true


  def full_name
    # create a full_name and strip any trailing whitespace, especially in case there is one missing first or last name
    "#{first_name} #{last_name}".strip
  end

end
