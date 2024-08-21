import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextScreen {
  static Future<void> normal(context, page) async {
    Navigator.push(context,
        Platform.isAndroid
            ? MaterialPageRoute(builder: (context) => page)
            : CupertinoPageRoute(builder: (context) => page)
    );
  }

  static Future<void> closeOthers(context, page) async {
    Navigator.pushAndRemoveUntil(context,
        Platform.isAndroid
            ? MaterialPageRoute(builder: (context) => page)
            : CupertinoPageRoute(builder: (context) => page)
        , (route) => false
    );
  }

  static Future<void> replace(context, page) async {
    Navigator.pushReplacement(context,
        Platform.isAndroid
            ? MaterialPageRoute(builder: (context) => page)
            : CupertinoPageRoute(builder: (context) => page)
    );
  }

  static Future<void> pop<T extends Object?>(BuildContext context, [ T? result ]) async {
    Navigator.of(context).pop<T>(result);
  }

  static Future<void> popup(context, page) async {
    Navigator.push(context,
        Platform.isAndroid
            ? MaterialPageRoute(fullscreenDialog: true, builder: (context) => page)
            : CupertinoPageRoute(fullscreenDialog: true, builder: (context) => page)
    );
  }

  static Future<void> replaceAnimation(context, page) async {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ),
    ));
  }

  static Future<void> closeOthersAnimation(context, page) async {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              ) =>
          page,
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
              ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        ),
        ((route) => false));
  }

  static Future<void> openBottomSheet(context, page, {double maxHeight = 0.95, bool isDismissable = true}) async {
    showModalBottomSheet(
      enableDrag: isDismissable,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: isDismissable,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * maxHeight,
      ),
      context: context,
      builder: (context) => page,
    );
  }

}