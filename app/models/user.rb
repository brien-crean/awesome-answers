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

  has_many :likes, dependent: :destroy
  # has_many :questions, through: :likes => cannot do this because there is already a has_many :questions above that will conflict with this line
  # instead do this below, its more descriptive, at the end specify that the other end of the relationship is question via source
  has_many :liked_questions, through: :likes, source: :question

  has_many :favourites, dependent: :destroy
  has_many :favourited_questions, through: :favourites, source: :question

  validates :email, presence: true, uniqueness: true

  has_many :votes, dependent: :nullify
  has_many :voted_questions, through: :votes, source: :question

  def full_name
    # create a full_name and strip any trailing whitespace, especially in case there is one missing first or last name
    "#{first_name} #{last_name}".strip
  end

end
