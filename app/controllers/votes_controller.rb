class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    question = Question.find params[:question_id]
    # will instantiate avote object pre-associated with the current user
    # which means 'vote' will have a user_id calue equivaleny to the current user
    vote = current_user.votes.new(vote_params)
    # is current_user shortcut possible because the user is associated with the question/vote?
    vote.question = question
    if vote.save
      redirect_to question_path(question), notice: "voted!"
    else
      redirect_to question_path(question), alert: "can't vote!"
    end
  end


  def destroy
    question = Question.find params[:question_id]
    vote = current_user.votes.find params[:id]
    question = Question.find params[:question_id]
    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to question_path(question), alert: "Vote Removed!"
  end

  def update
    question = Question.find params[:question_id]
    vote = current_user.votes.find params[:id]

    if vote.update vote_params
      redirect_to question_path(question), notice: "vote updated"
    else
      # question_path(question) can be refactored to just question as Rails will auto go to question_path
      redirect_to question_path(question), notice: "vote wasn't updated"
    end

  end

  def vote_params
    # reason for specifiying the vote: hash in show page vote butoons - can grab by :vote
    params.require(:vote).permit(:is_up)
  end

  # because accessing a method and a variable in ruby is the same
  # we can refactor to a method that finds the question
  def question
    # this can save a little time as we are caching the question 
    @question ||= Question.find params[:question_id]
  end

end
