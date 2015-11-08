class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    # only fetches the user if current_user is not already set, i.e. only if @current_user is nil
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  # by adding a helper_method and passing a method name Rails will make this
  # method a helper method which means it will be accessible from the views
  # as well as the controller

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user
      unless user_signed_in?
        redirect_to new_session_path, alert: "Please sign in!"
      end
  end

end
