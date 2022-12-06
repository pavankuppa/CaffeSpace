class OrderNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'order_notification'
  end
end
