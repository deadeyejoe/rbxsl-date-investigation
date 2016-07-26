class RollbarWorker
  include Sidekiq::Worker

  def perform message = nil
    Rollbar.error message || "The default error"
  end
end
