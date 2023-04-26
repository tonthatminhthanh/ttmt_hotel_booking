import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message, required int duration})
{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: duration), backgroundColor: Colors.pinkAccent,)
  );
}