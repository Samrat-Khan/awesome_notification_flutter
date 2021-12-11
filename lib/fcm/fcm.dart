import 'package:awesome_notification/notification/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fcm {
  final pushNotification = PushNotification.to;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  fcmRegister() {
    _firebaseMessaging.getToken().then((value) {
      debugPrint(value);
    });
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      debugPrint("message recieved");
      Map<String, dynamic> data = {
        "message": event.notification!.body,
        "title": event.notification!.title,
      };
      pushNotification.showNotification(
          title: data["title"], body: data["message"]);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      Map<String, dynamic> data = {
        "message": event.notification!.body,
        "title": event.notification!.title,
      };
      Get.toNamed('/show', arguments: data);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
