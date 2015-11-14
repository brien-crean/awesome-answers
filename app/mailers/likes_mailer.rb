class LikesMailer < ApplicationMailer
  def notify_owner_like(like)
    @like = like
    @question = like.question
    @owner = @question.user
    mail(to: @owner.email, subject: "You got a new like!")
  end
end
