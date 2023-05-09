import 'package:flutter/material.dart';

AlertDialog myAlert({required String content, required BuildContext context}) {
  return AlertDialog(
    content: Text(content),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Ok")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"))
    ],
  );
}
