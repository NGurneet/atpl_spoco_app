import 'package:flutter/material.dart';

Widget AppElevatedButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF48bb78),// Button background color
      
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Text color
      ),
    ),
    child: Text(text),
  );
}
