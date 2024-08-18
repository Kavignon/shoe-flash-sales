class PurchaseAlertsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'purchase_alerts_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
