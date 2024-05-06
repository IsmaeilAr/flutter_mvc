import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '../../shared/widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About us', search: false),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 20.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Gym Core',
                  style: TextStyle(
                    color: lightGrey,
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                const Text(
                  aboutUsFull,
                  style: TextStyle(
                    color: lightGrey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String aboutUsFull =
    ''' Welcome to Core Gym, your ultimate fitness companion designed to revolutionize your workout experience.

At Core Gym, we understand that achieving your fitness goals requires more than just physical effort; it requires motivation, guidance, and support. That's why we've created a comprehensive platform that caters to every aspect of your fitness journey, empowering you to reach new heights of strength, endurance, and well-being.

Our mission is simple: to inspire and empower individuals to lead healthier, happier lives through fitness. Whether you're a seasoned athlete or just starting out on your fitness journey, our app provides the tools and resources you need to succeed.

From personalized workout plans tailored to your goals and fitness level, to expert-led training programs and nutritional guidance, we're here to help you every step of the way. With access to a diverse range of workouts, including strength training, cardio, yoga, and more, you can mix up your routine and stay motivated.

But Core Gym is more than just a workout app—it's a community. Connect with like-minded individuals, share your progress, and cheer each other on as you crush your goals together. Whether you're sweating it out in the gym or working out from the comfort of your home, you're never alone on your fitness journey.

Join the Core Gym family today and take the first step towards a healthier, happier you. Let's make every workout count, together.''';
