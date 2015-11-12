class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  # ensures that the like uniquess is between a question and a user
  validates :question_id, uniqueness: {scope: :user_id}
end
