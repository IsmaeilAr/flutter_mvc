import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../shared/widgets/snackBar.dart';
import '../../../utils/helpers/api/api/api_helper.dart';
import '../../../utils/helpers/api/cacheKeys.dart';
import '../../auth/models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoadingCheckIn = false;

  bool get isLoadingCheckIn => _isLoadingCheckIn;

  set isLoadingCheckIn(bool value) {
    _isLoadingCheckIn = value;
    notifyListeners();
  }

  bool _isCheckIn = false;

  bool get isCheckIn => _isCheckIn;

  set isCheckIn(bool value) {
    _isCheckIn = value;
    notifyListeners();
  }

  bool _isLoadingActivePlayers = false;

  bool get isLoadingActivePlayers => _isLoadingActivePlayers;

  set isLoadingActivePlayers(bool value) {
    _isLoadingActivePlayers = value;
    notifyListeners();
  }

  List<UserModel> _activePlayersList = [];

  List<UserModel> get activePlayersList => _activePlayersList;

  set activePlayersList(List<UserModel> value) {
    _activePlayersList = value;
    notifyListeners();
  }

  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  Future<void> getActivePlayersApi(
    BuildContext context,
  ) async {
    isLoadingActivePlayers = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().activePlayerApi();
        isLoadingActivePlayers = false;
        results.fold((l) {
          isLoadingActivePlayers = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"]; //["player"];
            log("data $data");
            List<dynamic> list = data;
            activePlayersList =
                list.map((e) => UserModel.fromJson(e["player"])).toList();
            isLoadingActivePlayers = false;
          } else {
            isLoadingActivePlayers = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Active players : $e");
        showMessage("$e", false);
        isLoadingActivePlayers = false;
      }
    } else {
      showMessage('no internet', false);
      isLoadingActivePlayers = false;
    }
    notifyListeners();
  }

  Future<bool> callCheckInApi(
    BuildContext context,
  ) async {
    isLoadingCheckIn = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        DateTime content = DateTime.now();
        String theTime = content.toString();
        Either<String, Response> results = await ApiHelper().checkInApi(
          theTime,
        );
        isLoadingCheckIn = false;
        await results.fold((l) {
          isLoadingCheckIn = false;
          showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoadingCheckIn = false;
            repoStatus = true;
          } else {
            isLoadingCheckIn = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        showMessage("$e", false);
        isLoadingCheckIn = false;
        return false;
      }
    } else {
      showMessage('no internet', false);
      isLoadingCheckIn = false;
      return false;
    }
  }

  Future<bool> callCheckOutApi(
    BuildContext context,
  ) async {
    isLoadingCheckIn = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        var time = DateTime.now().toString();
        String content = time;
        Either<String, Response> results = await ApiHelper().checkOutApi(
          content,
        );
        isLoadingCheckIn = false;
        await results.fold((l) {
          isLoadingCheckIn = false;
          // showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            // var data = response.data["data"];
            // log("## $data");
            isLoadingCheckIn = false;
            repoStatus = true;
          } else {
            isLoadingCheckIn = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception {
        // showMessage("$e", false);
        isLoadingCheckIn = false;
        return false;
      }
    } else {
      showMessage('no internet', false);
      isLoadingCheckIn = false;
      return false;
    }
  }
}
