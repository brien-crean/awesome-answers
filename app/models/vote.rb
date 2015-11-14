class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  # ensure a user can only vote once on a question
  validates :question_id, uniqueness: {scope: :user_id}
end
