class AirConditionerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "air_conditioner_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
