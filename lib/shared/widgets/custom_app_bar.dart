import 'package:flutter/material.dart';
import 'package:flutter_mvc/features/home/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../styles/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool search;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.search,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: black,
      leading: IconButton(
        color: lightGrey,
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: lightGrey,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: search
          ? [
              IconButton(
                color: lightGrey,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: const MyHomePage()));
                },
                icon: const Icon(Icons.search),
              ),
            ]
          : null,
    );
  }
}
