import 'package:flutter/material.dart';

class promptBox {
  // Show the prompt dialog
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                // Execute confirm action and close dialog
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
