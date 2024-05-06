import 'package:flutter/material.dart';
import '../styles/decoration.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.black,
      child: Text(
        'Cancel',
        style: MyDecorations.programsTextStyle,
      ),
    );
  }
}
