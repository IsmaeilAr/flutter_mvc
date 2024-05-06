import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../shared/widgets/snackBar.dart';
import '../../../utils/helpers/api/api/api_helper.dart';
import '../../../utils/helpers/api/cacheKeys.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  Future<bool> callLoginApi(
    BuildContext context,
    String phone,
    String password,
  ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().loginApi(
          phone,
          password,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            String user = response.data["data"]["data"]["user"].toString();
            var userData = response.data["data"]["data"]["user"];
            log(data.toString());
            // log(user);
            String uToken = "Bearer ${data["data"]['token']}";
            // UserModel userModel = UserModel.fromJson(userData);
            UserModel coachModel = UserModel.fromJson(userData);
            await prefsService.setValue(CacheKeys.token, uToken);
            await prefsService.setValue(CacheKeys.isAuth, true);
            await prefsService.setValue(CacheKeys.userId, coachModel.id);
            await prefsService.setValue(CacheKeys.userName, coachModel.name);
            await prefsService.setValue(CacheKeys.userPhone, phone);
            await prefsService.setValue(CacheKeys.userPassword, password);
            // await prefsService.setValue(Cache.userImage,
            //     "${ApiHelper.imageUrl}${playerModel.images[0].image}");
            await prefsService.setValue(CacheKeys.user, user);
            // await prefs.setBool(Constants.firstOpen, true);
            // await prefs.setBool(Constants.isIphone, true);
            isLoading = false;
            repoStatus = true;
            log("login success $repoStatus");
          } else {
            isLoading = false;
            return false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        log("Exception : $e");
        isLoading = false;
        return false;
      }
    } else {
      showMessage('noInternet', false);
      isLoading = false;
      return false;
    }
  }

  Future<bool> callLogoutApi(
    BuildContext context,
  ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().logoutApi();
        isLoading = false;
        results.fold((l) {
          isLoading = false;
          showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            int? status = response.statusCode;
            String message = data['message'];
            debugPrint("## ${response.data}");
            if (status == 200) {
              isLoading = false;
              repoStatus = true;
              debugPrint("logged out");
              await prefsService.setValue(CacheKeys.token, '');
              await prefsService.setValue(CacheKeys.userPassword, '');
              await prefsService.setValue(CacheKeys.userPhone, '');
              await prefsService.setValue(CacheKeys.user, '');
              await prefsService.setValue(CacheKeys.userName, '');
              await prefsService.setValue(CacheKeys.userId, 0);
              await prefsService.setValue(CacheKeys.isAuth, false);
              debugPrint("cleared cache");
            } else {
              isLoading = false;
              showMessage(message, false);
              repoStatus = false;
            }
          } else {
            isLoading = false;
            debugPrint("## ${response.data}");
            return false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        debugPrint("Exception : $e");
        showMessage("$e", false);
        isLoading = false;
        return false;
      }
    } else {
      showMessage('no internet', false);
      isLoading = false;
      return false;
    }
  }

// Future<bool> callLogoutApi(BuildContext context) async {
//   isLoading = true;
//   isDeviceConnected = await InternetConnectionChecker().hasConnection;
//   bool repoStatus = false;
//   if (isDeviceConnected) {
//     try {
//       Either<String, Response> results = await ApiHelper().logoutApi();
//       isLoading = false;
//       await results.fold((l) {
//         isLoading = false;
//         repoStatus = false;
//       }, (r) async {
//         Response response = r;
//         if (response.statusCode == 200) {
//           isLoading = false;
//           repoStatus = true;
//           log("login success $repoStatus");
//         } else {
//           isLoading = false;
//           return false;
//         }
//       });
//       return repoStatus;
//     } on Exception catch (e) {
//       log("Exception : $e");
//       isLoading = false;
//       return false;
//     }
//   } else {
//     showMessage('no internet', false);
//     isLoading = false;
//     return false;
//   }
// }
}
