class MultiWorker
  include Sidekiq::Worker

  def perform threads, workers
    rng = Random.new

    threads.times do
      Thread.new do
        workers.times do
          DateWorker.perform_async
          sleep rng.rand(0.01)
        end
      end
    end
  end
end
