import 'package:awesome_notification/home.dart';
import 'package:awesome_notification/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnGenRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Homepage());
      case '/show':
        return MaterialPageRoute(
            builder: (_) => ShowMessage(
                  message: args as Map<String, dynamic>,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
