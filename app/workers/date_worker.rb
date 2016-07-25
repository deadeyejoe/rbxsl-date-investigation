class DateWorker
  include Sidekiq::Worker

  FIXED_TIME = Time.zone.now

  def perform
    @start_time = Time.zone.now

    num = Random.new.rand(12)

    if FIXED_TIME + num.hours < Time.zone.now
      logger.info "The app was started over #{num} hour(s) ago"
    end
  rescue ArgumentError => e
    logger.error "An argument error has occurred: #{e}"
    logger.error e.backtrace.join "\n"
  end
end
