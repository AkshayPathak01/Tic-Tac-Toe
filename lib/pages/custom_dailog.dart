import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:velocity_x/velocity_x.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textScaleFactor: 1.5,
        style: TextStyle(
            color: context.theme.accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0),
      ),
      content: Text(content),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new FlatButton(
          onPressed: callback,
          color: context.theme.cardColor,
          child: Text(actionText),
        )
      ],
    );
  }
}
