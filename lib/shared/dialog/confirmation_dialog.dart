import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/decoration.dart';
import 'cancel_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmationText;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmationText,
    required this.onConfirm,
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
        content,
        style: MyDecorations.coachesTextStyle,
      ),
      actions: [
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          color: primaryColor,
          child: Text(
            confirmationText,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
    );
  }
}
