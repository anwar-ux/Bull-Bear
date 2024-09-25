import 'package:flutter/material.dart';

Future<dynamic> customAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? firstButtonText,
  String? secondButtonText,
  void Function()? firstButtonAction,
  void Function()? secondButtonAction,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: firstButtonAction ?? () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(firstButtonText ?? 'OK'),
          ),
          if (secondButtonText != null)
            TextButton(
              onPressed: secondButtonAction ?? () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(secondButtonText),
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 24.0,
      );
    },
  );
}
