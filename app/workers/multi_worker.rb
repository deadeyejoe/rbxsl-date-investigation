class MultiWorker
  include Sidekiq::Worker

  READ_TIME = Time.zone.now

  def perform duration
    @rng = Random.new

    100.times do
      Thread.new do
        100.times do
          start_worker
        end
      end
    end

    reschedule duration
  end

  def start_worker
    Time.zone.now + @rng.rand(100)

    DateWorker.perform_async

    sleep @rng.rand(0.01)
  rescue ArgumentError => e
    logger.error "An argument error occurred! #{e}"
    logger.error e.backtrace.join "\n"
  end

  def reschedule duration
    unless READ_TIME + duration.seconds < Time.zone.now
      self.class.perform_in(@rng.rand(120).seconds, duration)
    end
  end
end
