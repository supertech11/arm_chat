const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore.document("messages/{docId}").
    onCreate((change, context) => {
      return admin.messaging().
          sendToTopic("chat", {notification: {title: change.data().sender,
            body: change.data().text,
            clickAction: "FLUTTER_NOTIFICATION_CLICK"}});
    });
