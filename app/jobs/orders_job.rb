class OrdersJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.status = Order::PROCESSED
    order.save!

    ActionCable.server.broadcast('order_notification', {
      id: order.id,
      order_number: order.order_number,
      status: order.status
    })
  end
end
