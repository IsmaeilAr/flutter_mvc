import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double? h;
  final double? w;
  final Widget? child;

  const Gap({super.key, this.h, this.w, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h?.h ?? 0,
      width: w?.w ?? 0,
      child: child,
    );
  }
}

Widget symmetricPadding({double? h, double? w, Widget? child}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: h?.h ?? 0, horizontal: w?.w ?? 0),
    child: child,
  );
}

Widget onlyPadding(
    {double? top, double? bottom, double? right, double? left, Widget? child}) {
  return Padding(
    padding: EdgeInsets.only(
        top: top?.h ?? 0,
        bottom: bottom?.h ?? 0,
        right: right?.w ?? 0,
        left: left?.w ?? 0),
    child: child,
  );
}
