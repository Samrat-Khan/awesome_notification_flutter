import 'package:awesome_notification/fcm/fcm.dart';
import 'package:awesome_notification/home.dart';
import 'package:awesome_notification/notification/push_notification.dart';
import 'package:awesome_notification/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(PushNotification());
  Fcm().fcmRegister();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pushNotification = PushNotification.to;
  @override
  void initState() {
    _pushNotification.permision(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onUnknownRoute: OnGenRoute.generateRoute,
    );
  }
}
