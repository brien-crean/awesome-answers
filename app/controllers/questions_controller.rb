#It is a rails convention to use the pluralised version of the model as the controller name if they are related
# - e.g. questions_controller for Question model
class QuestionsController < ApplicationController

  # authenticate_user is called before every action
  before_action :authenticate_user, except: [:index, :show]

  before_action :authorize, only: [:edit, :update, :destroy]

  #before action will register a method, e.g. (find question below) that will be executed before all actions
  # unless you specify options such as except or only
  # I commented out the old find statements
  # refactored code at end of controller
  before_action :find_question, only: [:show, :edit, :update, :destroy]


  def index
    # raise(params.inspect)
    # number_of_questions =
    # grab page_num from params, if nil set it to 1

    if params[:page_num]
      page_num = params[:page_num].to_i
    else
      page_num = 1
    end
    # byebug
    @questions = Question.get_page(page_num)
    # pagination not working
    # @questions = Question.all.order("updated_at DESC")
    # render text: page_num

  end

  def new
    # call method in ApplicationController to check of user is authenticated
    #authenticate_user
    # init var here so its not nil when /questions" => "questions#create is called
    # as without this line @q is nil
    @q = Question.new
  end

  def create
    # using require (grabs 'question key' from params => can be seen in the logs) and permit (only allows title and body parameters)
    # so if a hacker tries to pass a created_at, user_id by editing html in dev tools etc it will be denied by Rails
    question_params
    # byebug
    # code below refactored to a private questions param method
    # = params.require(:question).permit([:title, :body])
    # create as instance var so it can be shared with form
    @q = Question.new(question_params)

    # set the user_id for the question using the session variable
    @q.user = current_user

    if @q.save
      # render text: "Saved correctly"
      # redirect_to(question_path({id: @q.id}))
      redirect_to(question_path(@q), notice: "Question created!")
    else
      # render text: "Didn't save correctly #{q.errors.full_messages.join(", ")}"
      # send user back to the form
      render :new
    end

    # Question.create(question_params)
    #Mass Assignment Method: - not allowed due to security flaws
    # Question.create({title: params[:question]})
    #Verbose Method
    # Create a Question using form data posted via ActiveRecord - Verbose method
    # Question.create({title: params[:question][:title],
    #                  body: params[:question][:body]})
    # full params hash with other hashes inside
    # render text: "Inside Questions Create #{params}"
    # isolate the :question hash within params
    # render text: "Inside Questions Create #{params[:question]}"
  end

  def show
      # @q = Question.find(params[:id]) => refactored
      # instantiate an empty Answer object as we need a form on the show page to
      # create an answer for our question
      @answer = Answer.new
      # render text: params
  end

  def edit
      redirect_to root_path, alert: "Access Denied." unless can? :edit, @q
      # if current_user != @q.user
      #   redirect_to root_path, alert: "Access Denied."
      # end
      # @q = Question.find(params[:id])
  end

  def update
      # @q = Question.find(params[:id])

      # code below refactored to a private questions param method
      # question_params = params.require(:question).permit([:title, :body])
      #question_params method returns the same stuff

      if @q.update(question_params)
        redirect_to(question_path(@q), notice: "Question updated!")
      else
        render :edit
      end
  end

  def destroy
      # @q = Question.find(params[:id])
      @q.destroy
      # nottify using session that message deleted
      flash[:notice] = "Question deleted successfully"
      redirect_to questions_path
  end

  private

  def question_params
        #refactored code
        params.require(:question).permit([:title, :body, {tag_ids: []}])
        # {tag_ids: []} allows an array of values to be permitted when written in this way
  end

  def find_question
      @q = Question.find(params[:id])
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @q
  end

end
