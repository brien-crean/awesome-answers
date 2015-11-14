class QuestionsCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    
    Rails.logger.info "Hello World"
  end
end
