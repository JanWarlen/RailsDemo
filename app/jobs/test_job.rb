class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.info "#{self.class.name}: running job : #{args.inspect}"
  end
end
