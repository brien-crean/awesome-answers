namespace :gen_questions do

  # passing task name as key with value as environment ensures that rails
  # environment is loaded so you have access to all the models

  desc "Generate a 100 questions with 10 answers each"

  task gen_questions_and_answers: :environment do
    users = User.all
    100.times do
      q = Question.new(title: Faker::Company.catch_phrase,
                          body: Faker::Lorem.paragraph)
      q.user = users.sample
      q.save
      10.times do
        q.answers.create(body: Faker::Company.bs)
      end
    end

  end
      print Cowsay::say("Created 100 questions, with 10 Answers each")
end
