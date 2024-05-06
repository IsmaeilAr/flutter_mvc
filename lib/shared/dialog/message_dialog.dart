import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/decoration.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;

  const MessageDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      title: Text(
        title,
        style: MyDecorations.coachesTextStyle,
      ),
      content: Text(
        message,
        style: MyDecorations.coachesTextStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: primaryColor, // Set the text color
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: grey,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: MyDecorations.myFont,
            ),
          ),
        ),
      ],
    );
  }
}
