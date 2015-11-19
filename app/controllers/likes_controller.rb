class LikesController < ApplicationController
  before_action :authenticate_user

  # POST/questions/12/likes
  def create
    like          = Like.new
    question      = Question.friendly.find params[:question_id]
    like.question = question
    like.user     = current_user
    if like.save
      LikesMailer.notify_owner_like(Like.last).deliver_later
      redirect_to question_path(question), notice: "Liked!"
    else
      redirect_to question_path(question), alert: "Liked already!"
    end
  end

  def destroy
    question      = Question.friendly.find params[:question_id]

    # like = Like.find(params[:id]) # because the id for the Like is passed in params as :id
    # better option than above as now we are checking if the like belongs to the current user or not
    like = current_user.likes.find(params[:id]) # because the id for the Like is passed in params as :id
    like.destroy

    redirect_to question_path(question), alert: "Like removed!"
  end

end
