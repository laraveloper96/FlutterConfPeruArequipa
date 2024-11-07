import 'package:flutter/material.dart';

class Nav {
  static Future<void> root(BuildContext context, Widget page) async {
    await Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder<dynamic>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<void> go(BuildContext context, Widget page) async {
    await Navigator.push(
      context,
      PageRouteBuilder<dynamic>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> back(BuildContext context) async {
    Navigator.pop(context);
  }
}
