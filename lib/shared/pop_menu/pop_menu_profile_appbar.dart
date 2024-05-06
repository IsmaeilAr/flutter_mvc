import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/screens/login_screen.dart';
import '../dialog/confirmation_dialog.dart';
import 'menu_item_model.dart';

void onSelectedProfileAppBar(
    BuildContext context, MenuItemModel item, int id, String pageName) {
  switch (item.icon) {
    case Icons.stars:
      Navigator.push(
          context,
          PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.leftToRightWithFade));
      break;
    case Icons.close:
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: '',
          content: '',
          confirmationText: '',
          onConfirm: () {},
        ),
      );
      break;
  }
}
