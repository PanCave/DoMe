import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  const ErrorDialog({
    Key? key,
    required this.errorMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Da ist etwas schiefgelaufen!'),
      content: SingleChildScrollView(
        child: Text(errorMessage)
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          ),
      ],
    );
  }
}