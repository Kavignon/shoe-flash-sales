import consumer from "channels/consumer"

document.addEventListener('DOMContentLoaded', () => {
  function showToast(message) {
    if (typeof toastr !== 'undefined') {
      toastr.info(message, 'Notification', { closeButton: true, progressBar: true });
    } else {
      console.error("Toastr is not loaded.");
    }
  }

  consumer.subscriptions.create("PurchaseAlertsChannel", {
    connected() {
      console.log("Connection established");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log("Received data", data);
      showToast(data.message);
    }
  });
});


