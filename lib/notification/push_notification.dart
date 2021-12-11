import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class PushNotification extends GetxController {
  static PushNotification get to => PushNotification();

  @override
  void onInit() {
    AwesomeNotifications().initialize(
      '',
      [
        NotificationChannel(
          channelGroupKey: 'basic_tests',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: 'basic_tests',
          channelGroupName: 'Basic tests',
        ),
      ],
      debug: true,
    );

    super.onInit();
  }

  showNotification({required String title, required String body}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'basic_channel',
          title: title,
          body: body,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "action_1",
            label: "Action 1",
            buttonType: ActionButtonType.Default,
          ),
        ]);
    AwesomeNotifications().actionStream.listen((event) {
      Map<String, dynamic> data = {
        "message": event.body,
        "title": event.title,
      };
      Get.toNamed('/show', arguments: data);
    });
  }

  permision({required BuildContext context}) async {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  onClickNotification(Map<String, dynamic> message) {
    AwesomeNotifications().actionStream.listen((event) {
      Map<String, dynamic> data = {
        "message": event.body,
        "title": event.title,
      };
      Get.toNamed('/', arguments: data);
    });
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().actionStream.listen((event) {
    Map<String, dynamic> data = {
      "message": message.notification!.body,
      "title": message.notification!.title,
    };
    Get.toNamed('/show', arguments: data);
  });
}
