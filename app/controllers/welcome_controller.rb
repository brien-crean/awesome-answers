class WelcomeController < ApplicationController

  def index

  end

  def greeting
    # @name = "Brien"
    @name = params[:name]
  end

  #we call a method defined within the controller: it is called an action
  def hello
    # long hand: render({text: "Hello World"}) => returns the text as a response
    # render text: "Hello World"

    # this line is implied - not required - convention over configuration
    # render(:hello, {layout: "application"})
    # why? because rails automatically looks for a file called hello.html.erb in:
    # views -> welcome
    # if we got a request for hello.text
    # Rails will render: views/welcome/hello.text.erb => if it exists
  end
end
