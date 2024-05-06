import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
    this.action,
  });

  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: lightGrey,
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 20.r,
      ),
      onPressed: () {
        if (action != null) {
          action!();
        }
        Navigator.pop(context);
      },
    );
  }
}
