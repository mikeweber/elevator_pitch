class ElevatorChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info("Got a subscriber to ElevatorChannel")
    stream_for 'status'
  end
end
