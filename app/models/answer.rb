class Answer < ActiveRecord::Base
  # 'belongs_to' gives the answers class two methods a getter and setter to
  # associate a specific answer with a question
  # for instance to find a question for a given answer
  # a = Answer.find 1
  # q = a.question => returnds a question object whose id is a.question_id
  # to set a question for a given answer:
  #  a = Answer.new({body: "Abc"})
  #  q = Question.friendly.find(100)
  # a.question = q
  # a.save
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
end
