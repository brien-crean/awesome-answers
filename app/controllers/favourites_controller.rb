class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    favourite           = Favourite.new
    # favourite           = current_user.favourites.new
    question            = Question.friendly.find params[:question_id]
    favourite.question  = question
    favourite.user      = current_user
    if favourite.save
      redirect_to question_path(question), notice: "Faved!"
    else
      redirect_to question_path(question), alert: "Faved already!"
    end
  end

  def destroy
    question      = Question.friendly.find params[:question_id]

    favourite     = current_user.favourites.find(params[:id]) # because the id for the Like is passed in params as :id
    favourite.destroy

    redirect_to question_path(question), alert: "Fave removed!"
  end

end
