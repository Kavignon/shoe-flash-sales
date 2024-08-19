import consumer from "channels/consumer"

document.addEventListener('DOMContentLoaded', () => {

  consumer.subscriptions.create("PurchaseAlertsChannel", {
    connected() {
      console.log("Connection established");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log("Received data", data);
      document.getElementById('success-audio').play();
    }
  });
});


