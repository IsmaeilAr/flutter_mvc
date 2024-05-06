import 'dart:developer';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/utils/extensions/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/decoration.dart';
import '../../../shared/widgets/gap.dart';
import '../../../shared/widgets/snackBar.dart';
import '../../../utils/helpers/api/cacheKeys.dart';
import '../../mainLayout/screens/main_layout_screen.dart';
import '../controller/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Gap(
                  h: 108,
                ),
                const Logo().sizer(h: 55, w: 116),
                const Gap(
                  h: 60,
                ),
                const WelcomeText(),
                const Gap(
                  h: 64,
                ),
                const LoginForm(),
                const Gap(
                  h: 50,
                ),
              ],
            ),
          ),
        ),
        // persistentFooterButtons:
      ),
    );
  }
}

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        'assets/images/background-login.png',
      ),
      fit: BoxFit.cover,
    ),
  );
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/svg/Logo.svg',
      height: 100,
      width: 70,
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'welcome',
            textAlign: TextAlign.center,
            style: TextStyle(color: lightGrey, fontSize: 30.sp),
          ).sizer(h: 47, w: 140), //128
          const Gap(
            h: 12,
          ),
          Text(
            'Enter email and password',
            textAlign: TextAlign.center,
            style: TextStyle(color: grey, fontSize: 16.sp),
          ).sizer(
            w: 260,
            h: 31,
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscured = true;
  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  @override
  void initState() {
    super.initState();
    _phoneController.text = "0935622242";
    _passwordController.text = "123456789";
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
        onFirstBackPress: (context) {
          showMessage('Press Again', true);
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: MyDecorations.myInputDecoration(
                      hint: 'phone',
                      icon: const Icon(
                        Icons.phone,
                        size: 20,
                        color: iconColor,
                      )),
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .loginEnterMobileNumberKey;
                    }
                    return null;
                  },
                ), // .sizer(h: 42, w: 332),
                const Gap(h: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: obscured,
                  decoration: MyDecorations.myInputDecoration(
                      hint: 'password',
                      icon: const Icon(
                        Icons.lock,
                        size: 20,
                        color: iconColor,
                      ),
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscured = !obscured;
                            });
                          },
                          icon: Icon(
                            obscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                            color: iconColor,
                          ))),
                  onFieldSubmitted: (_) => {
                    if (_formKey.currentState!.validate())
                      {
                        doLogin(context),
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: const MainLayout())),
                      }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .loginEnterPasswordKey;
                    }
                    return null;
                  },
                ),
                const Gap(h: 30),
                SizedBox(
                  width: 242.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!context.read<AuthProvider>().isLoading &&
                          _formKey.currentState!.validate()) {
                        doLogin(context);
                      }
                    },
                    style: MyDecorations.myButtonStyle(red),
                    child: !context.watch<AuthProvider>().isLoading
                        ? Text(
                            'login',
                            style: MyDecorations.myButtonTextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                          )
                        : SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: const CircularProgressIndicator.adaptive(
                              strokeWidth: 1,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(lightGrey),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void doLogin(BuildContext context) {
    context
        .read<AuthProvider>()
        .callLoginApi(context, _phoneController.text, _passwordController.text)
        .then((value) {
      if (value) {
        log("view status: $value");
        // context.read<ProfileProvider>().getCoachInfo(
        //       context,
        //     );
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const MainLayout(),
                type: PageTransitionType.leftToRightWithFade));
      } else {
        // showMessage("Login failed !", false); // todo localize
      }
    });
  }
}
