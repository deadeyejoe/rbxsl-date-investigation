class DateWorker
  include Sidekiq::Worker

  FIXED_TIME = Time.zone.now

  def perform
    @start_time = Time.zone.now

    if FIXED_TIME + 1.hour < Time.zone.now
      logger.info "The app was started over an hour ago"
    end

    if @start_time < Time.zone.now + 1.minute
      logger.info "The first rule of tautology club is the first rule of tautology club!"
    end
  rescue ArgumentError => e
    logger.error "An argument error has occurred: #{e}"
    logger.error e.backtrace.join "\n"
  end
end
