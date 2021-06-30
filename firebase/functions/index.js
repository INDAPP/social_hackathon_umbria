const functions = require("firebase-functions");

const admin = require('firebase-admin');
admin.initializeApp();

exports.PushNotifications = functions.firestore
    .document('posts/{postId}')
    .onCreate(async (snapshot, context) => {

      const userId = snapshot.data().authorId
      const user = userId != null ? (await admin.auth().getUser(userId)) : null
      const userName = user != null ? user.displayName : null

      const content = snapshot.data().content

      const notification = {
        title: userName != null ? ('Nuovo Post da ' + userName) : 'Nuovo Post pubblicato',
        body: content.length > 200 ? 
            content.substring(0, 197) + "..." : 
            content,
      }

      await admin.messaging().sendToTopic(
          'posts',
          {
            notification: notification,
          }
        )
    })