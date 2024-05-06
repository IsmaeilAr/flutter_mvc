import 'package:flutter/material.dart';
import 'package:flutter_mvc/features/home/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/gym_icons.dart';
import '../../shared/widgets/gap.dart';
import '../../utils/localization/language_provider.dart';
import '../auth/controller/auth_provider.dart';
import '../auth/screens/login_screen.dart';
import '../mainLayout/controller/main_layout_provider.dart';
import 'about_us_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  // SharedPreferencesService prefsService = SharedPreferencesServiceF.instance;

  // @override
  @override
  Widget build(BuildContext context) {
    // SharedPreferencesService prefsService = SharedPreferencesService.instance;
    // String userName = prefsService.getValue(CacheKeys.userName) ?? "";
    // String userPhone = prefsService.getValue(CacheKeys.userPhone) ?? "";
    // CoachModel coachInfo=context.watch<ProfileProvider>().coachInfo;
    return Drawer(
      backgroundColor: black,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.fromLTRB(14.w, 46.h, 16.w, 50.h),
            child: GestureDetector(
              onTap: () {
                // context.read<MainLayoutProvider>().selectedIndex = 3;
                Scaffold.of(context).openEndDrawer();
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const AssetImage(''),
                  ),
                  Gap(
                    w: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 22.h,
                        child: const Text(
                          'name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: lightGrey,
                          ),
                        ),
                      ),
                      const Text(
                        '0987654321',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const LanguageList(),
          ListTile(
            leading: const Icon(
              MyIcons.report,
              color: lightGrey,
              size: 18,
            ),
            title: const Text(
              'Report',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lightGrey),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: const MyHomePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.sports_gymnastics,
              color: lightGrey,
            ),
            title: const Text(
              'About us',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lightGrey),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: const AboutUsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              MyIcons.logOut,
              size: 18,
              color: lightGrey,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lightGrey),
            ),
            onTap: () {
              doLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

doLogout(BuildContext context) {
  context
      .read<AuthProvider>()
      .callLogoutApi(context)
      .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          ));
}

class LanguageList extends StatefulWidget {
  const LanguageList({super.key});

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  bool _showLanguage = false;

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        context.watch<LanguageProvider>().appLocale.languageCode == 'en';
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {
              setState(() {
                _showLanguage = !_showLanguage;
              });
            },
            leading: const Icon(
              Icons.language_outlined,
              color: lightGrey,
            ),
            title: const Text(
              'Language',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lightGrey),
            ),
            trailing: SizedBox(
              width: 35.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isEnglish ? "EN" : "AR",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 10, color: grey),
                  ),
                  Icon(
                    _showLanguage
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    color: grey,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: Padding(
              padding: EdgeInsets.only(right: 37.w, left: 37.w),
              child: ListTile(
                onTap: () {
                  context
                      .read<LanguageProvider>()
                      .changeLanguage(const Locale('en', '')); // todo localize
                },
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(start: 8.w),
                  child: isEnglish
                      ? const SelectedLangIcon()
                      : const UnSelectedLangIcon(),
                ),
                title: Text(
                  'English',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: !isEnglish ? lightGrey : grey),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: Padding(
              padding: EdgeInsets.only(right: 37.w, left: 37.w),
              child: ListTile(
                onTap: () {
                  context
                      .read<LanguageProvider>()
                      .changeLanguage(const Locale('ar', '')); // todo localize
                },
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(start: 8.w),
                  child: !isEnglish
                      ? const SelectedLangIcon()
                      : const UnSelectedLangIcon(),
                ),
                title: Text(
                  'العربية',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: isEnglish ? lightGrey : grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnSelectedLangIcon extends StatelessWidget {
  const UnSelectedLangIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.radio_button_off_outlined,
      color: lightGrey,
      size: 16,
    );
  }
}

class SelectedLangIcon extends StatelessWidget {
  const SelectedLangIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.radio_button_checked_outlined,
      color: grey,
      size: 16,
    );
  }
}
