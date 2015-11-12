class AnswersController < ApplicationController

  before_action :authenticate_user

  def create
    # grab params using strong params features
    # Params example: "answer"=>{"body"=>"fdsfdsfdsfdf"}, "commit"=>"Create Answer", "controller"=>"answers", "action"=>"create", "question_id"=>"10"}
    answer_params = params.require(:answer).permit(:body)

    # params[:question_id] is coming from the URL which looks like
    # questions/10/answers
    # find question in DB using question_id passed in params
    @q = Question.find params[:question_id]

    # create answer in Answer table using params data
    @answer = Answer.new(answer_params)


    # associate answer with question
    @answer.question = @q

    @answer.user = current_user
    # shortcut of above
    #@answer = current_user.answers.new(answer_params)
    # byebug
    if @answer.save
      # e.g. To look at what we receive in params
      # render text: params
      # redirect to question
      redirect_to question_path(@q), notice: "Answer created successfully!"
    else
      # display the same page
      render "questions/show"
    end
  end

  def destroy
    # find_by_id => returns nil if not found
    # find       => throws an execption if not found
    answer = Answer.find params[:id]
    redirect_to root_path, alert: "Access Denied." unless can?(:destroy, answer)
    answer.destroy
    # passes the question_id associated with the answer back to the questions#show page
    redirect_to question_path(answer.question), notice: "Answer Deleted!"
  end

end
