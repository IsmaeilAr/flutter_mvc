import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/decoration.dart';

class Divider1 extends StatelessWidget {
  final String title;

  const Divider1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: MyDecorations.profileGreyTextStyle,
            ),
            Expanded(
              child: Divider(
                color: dark,
                thickness: 1.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
