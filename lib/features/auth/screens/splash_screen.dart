import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../utils/helpers/api/api/api_helper.dart';
import '../../../utils/helpers/api/cacheKeys.dart';
import '../../mainLayout/screens/main_layout_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // final WebSocketChannel channel;

  // const SplashScreen({super.key, required this.channel});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Import for Timer class

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  @override
  void initState() {
    initData();
    ApiHelper.setupInterceptors(context);
    super.initState();
  }

  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(CacheKeys.token) ?? "";
    bool isAuth = prefs.getBool(CacheKeys.isAuth) ?? false;

    if (isAuth && token.isNotEmpty) {
      // Check if the token is expired
      bool isTokenExpired = isExpired(token);

      if (!isTokenExpired) {
        // Token is not expired, navigate to main layout
        navigateToMainLayout();
      } else {
        // Token is expired, navigate to login screen
        navigateToLoginPage();
      }
    } else {
      navigateToLoginPage();
    }

    // Set loading indicator to false once initialization is complete
    setState(() {
      _isLoading = false;
    });
  }

  bool isExpired(String token) {
    bool hasExpired = JwtDecoder.isExpired(token);
    return hasExpired;
  }

  void navigateToMainLayout() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: MainLayout(),
      ),
    );
    // context.read<ProfileProvider>().getCoachInfo(context,);
  }

  void navigateToLoginPage() {
    // int coachId=prefsService.getValue(CacheKeys.userId);
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: LoginScreen(),
      ),
    );
    // context.read<ProfileProvider>().getCoachInfo(context,coachId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const LoadingIndicatorWidget() // Show loading indicator if still loading
            : const SizedBox(), // Otherwise, show nothing
      ),
    );
  }
}
