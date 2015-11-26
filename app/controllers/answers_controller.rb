class AnswersController < ApplicationController

  before_action :authenticate_user

  def create
    # grab params using strong params features
    # Params example: "answer"=>{"body"=>"fdsfdsfdsfdf"}, "commit"=>"Create Answer", "controller"=>"answers", "action"=>"create", "question_id"=>"10"}
    answer_params = params.require(:answer).permit(:body)

    # params[:question_id] is coming from the URL which looks like
    # questions/10/answers
    # find question in DB using question_id passed in params
    @q = Question.friendly.find params[:question_id]

    # create answer in Answer table using params data
    @answer = Answer.new(answer_params)


    # associate answer with question
    @answer.question = @q

    @answer.user = current_user
    # shortcut of above
    #@answer = current_user.answers.new(answer_params)
    # byebug

    respond_to do |format|

      if @answer.save
        # notify question owner that the question has a new answer
        # AnswersMailer.notify_question_owner(Answer.last).deliver_now
        # e.g. To look at what we receive in params
        # render text: params
        # redirect to question
        format.html  {redirect_to question_path(@q), notice: "Answer created successfully!"}
        # template render: this will render views/answers/create_success.js.erb
        format.js {render :create_success}
      else
          # display the same page
        format.html {render "questions/show"}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    # find_by_id => returns nil if not found
    # find       => throws an execption if not found
    @answer = Answer.find params[:id]
    redirect_to root_path, alert: "Access Denied." unless can?(:destroy, @answer)
    @answer.destroy
    respond_to do |format|
      # passes the question_id associated with the answer back to the questions#show page
      format.html {redirect_to question_path(@answer.question), notice: "Answer Deleted!"}
      format.js { render } # by default renders views/answers/destroy.js.erb
    end
  end

end
