class Question < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  # can do this for many to many
  # has_many :users, through: :likes
  # however this is more descriptive
  # source: :user matches belongs_to: user in like.rb
  has_many :liking_users, through: :likes, source: :user

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user
                              # favourites references the previous has many statement => has to match
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # pagination
  QUESTIONS_PER_PAGE = 10.0

  # when using has_many :answers we expect that we have a model named Answer
  # we use the dependent option to maintain referential integrity, we have 2 options:
  # 1. use {dependent: :destroy}) this willd estroy all answers referencing a question
  # before deleting the question
  # 2. use {dependent: :nullify}) will make 'question_id' value for all
  # answers referencing a question 'null' before deleting the question
  has_many(:answers, {dependent: :destroy})

  # validation - has to be present in record to be added to DB
  validates(:title, {presence: true,
                     uniqueness: {message: "was used already"},
                     length:      {minimum: 3}}) # custom error message q.errors will list this

# prevents somone from entering the text Example2
validates_format_of :title, without: /Example2/

  validates :body, presence: true,
                   uniqueness: {scope: :title}
                   # using scope: rails will make sure that the body is unique
                   # in combination with the title


                         # numericality can be passed arguments
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # custom validate method
  validate :no_monkey

  # utilizing the lifecycle and default methods to set defaults
  # called after object initialization e.g. q = Question.new
  after_initialize :set_default_values
  before_validation :capitalize_title

  def liked_by?(user)
    # Question.likes
    likes.find_by_user_id(user.id).present?
    # like_for(user).present? = > refactor
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def favourited_by?(user)
    # Question.likes
    favourites.find_by_user_id(user.id).present?
    # like_for(user).present? = > refactor
  end

  def favourite_for(user)
    favourites.find_by_user_id(user.id)
  end

  # shorthand instead of defining a class method => use scope method with a lambda
  # scope(:recent_ten, lambda {order("created_at DESC").limit(10)})
  # class method to check the last 10 recent questions => needs to be a class method so it can be called on the model
  def self.recent_ten
    order("created_at DESC").limit(10)
  end

  def self.recent(num_records)
    order("created_at DESC").limit(num_records)
  end

  def self.search(term)
    term = "%#{term}%"
    where(["title ILIKE ? OR body ILIKE ?", term, term ])
    # another more easy to read way
    where(["title ILIKE :search_term OR body ILIKE :search_term", {search_term: "%#{term}%"} ])
  end

  def self.days_ago(days)
    where(["created_at > ?", (Date.today - days)])
  end

  def self.get_page(page_num)
    offset_page = page_num - 1
    offset_value = offset_page * QUESTIONS_PER_PAGE
    offset(offset_value).limit(QUESTIONS_PER_PAGE)
    # byebug
    # all.limit(params[:page_num])
  end

  def self.num_of_pages
    num_of_pages = (Question.count / QUESTIONS_PER_PAGE).round
  end

  private

  #customterm method
  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys please!")
    end
  end

  def set_default_values
    # if view_count is nil or false set it to 7
    self.view_count ||= 7
  end

  def capitalize_title
    self.title.capitalize! if title
  end


end
