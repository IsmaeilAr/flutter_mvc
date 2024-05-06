import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/gym_icons.dart';
import '../../../shared/widgets/icon_button.dart';
import '../../../shared/widgets/snackBar.dart';
import '../../drawer/drawer_widget.dart';
import '../../home/screens/home_screen.dart';
import '../controller/main_layout_provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final pageIconList = <IconData>[
    Icons.home,
    // MyIcons.programs,
    // MyIcons.community,
    // MyIcons.profile,
  ];

  final screens = <Widget>[
    const MyHomePage(),
    // const HomeScreen(),
    // const HomeScreen(),
    // const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        context.watch<MainLayoutProvider>().selectedIndex;

    List<String> screenNames = [
      'Home',
      // AppLocalizations.of(context)!.mainLayoutAppBarProgramsScreenName,
      // AppLocalizations.of(context)!.mainLayoutAppBarPlayersScreenName,
      // AppLocalizations.of(context)!.mainLayoutAppBarProfileScreenName,
    ];

    return DoubleBack(
        onFirstBackPress: (context) {
          showMessage('press again', true);
        },
        child: Scaffold(
          appBar: MainAppBar(
            title: screenNames[selectedIndexProvider],
          ),
          body: Container(child: screens[selectedIndexProvider]),
          drawer: const MyDrawer(),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 47.w,
            ),
            child: GNav(
              backgroundColor: black,
              hoverColor: red,
              activeColor: red,
              iconSize: 24.dm,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              duration: const Duration(milliseconds: 400),
              tabs: [
                GButton(
                  icon: pageIconList[0],
                  iconColor: grey,
                ),
                // GButton(
                //   icon: pageIconList[1],
                //   iconColor: grey,
                // ),
                // GButton(
                //   icon: pageIconList[2],
                //   iconColor: grey,
                // ),
                // GButton(
                //   icon: pageIconList[3],
                //   iconColor: grey,
                // ),
              ],
              selectedIndex: selectedIndexProvider,
              onTabChange: (index) {
                context.read<MainLayoutProvider>().selectedIndex = index;
              },
            ),
          ),
        ));
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(52.h);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: black,
      leading: BarIconButton(
        icon: Icons.menu,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: lightGrey, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      actions: [
        BarIconButton(
          icon: Icons.notifications_none_outlined,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: const MyHomePage()));
          },
        ),
      ],
    );
  }
}
