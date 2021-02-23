import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

Future<void> showAlertDialog(
    {@required BuildContext context,
    @required String title,
    @required String content,
    @required String actionText}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(actionText)),
              ],
            ));
  }
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(actionText)),
            ],
          ));
}
