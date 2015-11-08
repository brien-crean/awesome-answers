class SessionsController < ApplicationController
  def new
  end

  def create
    params[:email]
    params[:password]

    # attempt to find the user by email => find_by_email will return at most 1 record
    # if no user found with given email => nil is returned
    user = User.find_by_email params[:email]
    # check if user exists first and then check if password matches in database
    # authenticate will return false if password is wrong and will return the user if the password is correct
    if user && user.authenticate(params[:password])
      # we use session ADD NOTES
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in!"
    else
      flash[:alert] = "Wrong credentials!"
    end

    # render text: params
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out!"
  end

end
