import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class MyDecorations {
  static String myFont = "Saira";

  static InputDecoration myInputDecoration({
    required String hint,
    Widget? icon,
    String? prefix,
    Widget? suffix,
  }) {
    double borderRadius = 8.r;
    double fontSize = 15.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.h,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: lightGrey,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      labelStyle: TextStyle(color: black, fontSize: fontSize.sp),
      hintStyle: TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle: TextStyle(color: red, fontSize: fontSize.sp),
      prefixIcon: icon,
      prefixText: prefix,
      suffixIcon: suffix,
    );
  }

  static InputDecoration myInputDecoration2({
    required String hint,
    Widget? icon,
    String? prefix,
    Widget? suffix,
  }) {
    double borderRadius = 8.r;
    double fontSize = 15.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.h,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: lightGrey,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),

      labelStyle: TextStyle(color: black, fontSize: fontSize.r),
      hintStyle: TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle: TextStyle(color: red, fontSize: fontSize.sp),

      prefixIcon: icon,
      prefixText: prefix,
      suffix: suffix,
      // suffix: Text(suffix, style: mySuffixTextStyle,),
    );
  }

  static InputDecoration myInputDecoration3({
    required String hint,
    Widget? icon,
    String? prefix,
    Widget? suffix,
  }) {
    double borderRadius = 8.r;
    double fontSize = 12.sp;
    FontWeight fontWeight = FontWeight.w400;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.w,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: black,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),

      labelStyle:
          TextStyle(color: black, fontSize: fontSize, fontWeight: fontWeight),
      hintStyle: TextStyle(
          color: lightGrey, fontSize: fontSize, fontWeight: fontWeight),
      errorStyle:
          TextStyle(color: red, fontSize: fontSize, fontWeight: fontWeight),

      prefixIcon: icon,
      prefixText: prefix,
      suffix: suffix,
      // suffix: Text(suffix, style: mySuffixTextStyle,),
    );
  }

  static InputDecoration myInputDecoration4({
    required String hint,
    Widget? icon,
    String? prefix,
    Widget? suffix,
  }) {
    double borderRadius = 17.r;
    double fontSize = 12.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.w,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: dark,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: dark,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: dark,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: dark,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: dark,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),

      labelStyle: TextStyle(color: black, fontSize: fontSize.sp),
      hintStyle: TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle: TextStyle(color: red, fontSize: fontSize.sp),

      prefixIcon: icon,
      prefixText: prefix,
      suffix: suffix,
      // suffix: Text(suffix, style: mySuffixTextStyle,),
    );
  }

  static ButtonStyle myButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
    );
  }

  static ButtonStyle profileButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      //padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
    );
  }

  static TextStyle myButtonTextStyle(
      {required double fontSize, required FontWeight fontWeight}) {
    return TextStyle(
      color: lightGrey,
      fontFamily: myFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.0, // line height in terms of multiplier
    );
  }

  static TextStyle mySuffixTextStyle = TextStyle(
      color: grey,
      fontFamily: myFont,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.0);

  static TextStyle activePlayerTextStyle = TextStyle(
    color: grey,
    fontFamily: myFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle programsTextStyle = TextStyle(
    color: grey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle coachesTextStyle = TextStyle(
    color: lightGrey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle premiumTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle calendarTextStyle = TextStyle(
    color: lightGrey,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: myFont,
  );

  static TextStyle profileLight400TextStyle = TextStyle(
    color: lightGrey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: myFont,
  );

  static TextStyle profileLight500TextStyle = TextStyle(
    color: lightGrey,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle profileGreyTextStyle = TextStyle(
    color: grey,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle profileGrey400TextStyle = TextStyle(
    color: grey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: myFont,
  );

  static TextStyle MonthlySubscriptionsTextStyle = TextStyle(
    color: grey,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: myFont,
  );
  static TextStyle playerProfileTextStyle = TextStyle(
      color: lightGrey,
      fontFamily: myFont,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.0);

  static BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: black,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        color: grey,
      ),
    );
  }

  static TextStyle sectionTextStyle() {
    return TextStyle(
      color: lightGrey,
      fontFamily: MyDecorations.myFont,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }
}
