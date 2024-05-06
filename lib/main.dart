import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mvc/shared/styles/colors.dart';
import 'package:flutter_mvc/shared/styles/decoration.dart';
import 'package:flutter_mvc/utils/helpers/api/cacheKeys.dart';
import 'package:flutter_mvc/utils/localization/language_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'features/auth/controller/auth_provider.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/home/controller/home_provider.dart';
import 'features/home/screens/home_screen.dart';
import 'features/mainLayout/controller/main_layout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSharedPreferences();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => MainLayoutProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym Coach',
        locale: languageProvider.appLocale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          // colorScheme: darkThemeColors, // need to extract flutter widget...
          scaffoldBackgroundColor: black,
          fontFamily: MyDecorations.myFont,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
