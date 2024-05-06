import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/utils/helpers/api/api/session_expired_interceptor.dart';
import '../../../../shared/widgets/snackBar.dart';
import '../cacheKeys.dart';
import 'api_constants.dart';
import 'dio_exceptions.dart';

class ApiHelper {
  SharedPreferencesService prefsService = SharedPreferencesService.instance;

//#########################################################################
  static final BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  static final Dio _clientDio = Dio(options);

  static Duration connectionTimeoutValue = const Duration(seconds: 30);
  static Duration receiveTimeoutValue = const Duration(seconds: 30);

  static Dio get clientDio => _clientDio;

  static void setupInterceptors(BuildContext context) {
    _clientDio.interceptors.add(
      SessionExpiredInterceptor(context),
    );
  }

//#########################################################################

  Future<Either<String, Response>> loginApi(
    String phone,
    String password,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      var response = await _clientDio
          .post(ApiConstants.loginUrl,
              data: {
                'phoneNumber': phone,
                'password': password,
              },
              options: Options(
                headers: {
                  'Accept': 'application/json',
                },
              ))
          .timeout(const Duration(seconds: 25));
      debugPrint("## $Response login (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      showMessage(errorMessage, false);
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMonthlyProgressApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.monthlyUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get monthly progress : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> activePlayerApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .get(ApiConstants.activePlayersUrl,
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': token,
                },
              ))
          .timeout(const Duration(seconds: 25));
      debugPrint("## $Response active player (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> checkInApi(
    String content,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.checkInUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "startTime": content,
        },
      ).timeout(const Duration(seconds: 25));
      debugPrint("## Response checkIn (API handler) : Good ");
      debugPrint("## Response checkIn : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getAllCategoriesApi(String type) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.allCategoriesUrl(type),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get all Categories : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyProgramsApi(
      String type, int categoryID, String programType) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.myProgramsUrl(type, categoryID, programType),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get all Programs : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyPlayersApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .get(ApiConstants.showMyPlayersUrl,
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': token,
                },
              ))
          .timeout(const Duration(seconds: 25));
      debugPrint("## $Response get My players (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMonthlySubscriptionsApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.monthlySubscriptionsUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response monthly  subscriptions (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> searchProgramsApi(
    String content,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio.post(
        ApiConstants.programSearchUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "search_text": content,
        },
      ).timeout(const Duration(seconds: 50));
      debugPrint("## Response search program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getPlayerMetricsApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getPersonMetricsUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response Player Metrics (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getPlayerInfoApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getPersonInfoUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response Player Info (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getPlayerImagesApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getPlayerImagesUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response Player Images (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getCoachInfoApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    int id = prefsService.getValue(CacheKeys.userId) ?? 0;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getCoachInfoUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response Caoch Info (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editInfoApi(
      String name, String phoneNumber, File? image, String bio) async {
    late Either<String, Response> result;
    var formData = (image != null)
        ? FormData.fromMap({
            "name": name,
            "phoneNumber": phoneNumber,
            'image[0]': await MultipartFile.fromFile(
              image.path,
            ),
            "bio": bio,
          })
        : FormData.fromMap({
            "name": name,
            "phoneNumber": phoneNumber,
            "bio": bio,
          });
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.editCoachInfoUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
            data: formData,
          )
          .timeout(const Duration(seconds: 60));
      debugPrint("## Response edit info (API handler) : Good ");
      debugPrint("## Response edit info : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error editInfoApi");
      final errorMessage = e.response?.data['data'];
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> sendReportApi(String text) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio.post(ApiConstants.sendReportUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token,
            },
          ),
          data: {
            "text": text,
          }).timeout(const Duration(seconds: 50));
      debugPrint("## $Response send report (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyArticlesApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.myArticlesUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response my articles (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getAllArticleApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.allArticleUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response All articles (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteMyArticleApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .delete(
            ApiConstants.deleteMyArticleUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response delete my article (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addArticleApi(
      String title, String content) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio.post(ApiConstants.addArticleUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token,
            },
          ),
          data: {
            "title": title,
            "content": content,
          }).timeout(const Duration(seconds: 50));
      debugPrint("## $Response add article (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> logoutApi() async {
    late Either<String, Response> result;

    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.logoutUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 25));
      debugPrint("## Response logout : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getChatMessagesApi(userId) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.chatMessagesUrl(userId),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get chat : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getChatsApi() async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getChatsUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get chat list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> sendMessageApi(
    int receiverID,
    String content,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.sendMessageUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "content": content,
          "receiver_id": receiverID,
        },
      ).timeout(const Duration(seconds: 25));
      debugPrint("## Response send message (API handler) : Good ");
      debugPrint("## Response send message : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteMessageApi(
    int messageID,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.deleteMessageUrl(messageID),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "message_id": messageID,
        },
      ).timeout(const Duration(seconds: 25));
      debugPrint("## Response delete message (API handler) : Good ");
      debugPrint("## Response delete message : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getAllPlayersApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .get(ApiConstants.showAllPlayersUrl,
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': token,
                },
              ))
          .timeout(const Duration(seconds: 25));
      debugPrint("## $Response get All players (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getCoachTimeApi(int coachId) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.showCoachTimeUrl(coachId),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get Coach Time list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getNotificationsApi() async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getNotificationsUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get Notifications list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> checkOutApi(String endTime) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.checkOutUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "endTime": endTime,
        },
      ).timeout(const Duration(seconds: 25));
      debugPrint("## Response checkOut (API handler) : Good ");
      debugPrint("## Response checkOut : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getRequestProgrameApi() async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getRequestProgrameUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## Response get Requests list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> acceptOrderApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .post(
            ApiConstants.acceptOrderUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response accept order (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> rejectOrderApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .post(
            ApiConstants.rejectOrderUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response reject order (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> removePlayerApi(int id) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.removePlayerUrl(id),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response remove my player (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addImagesApi(
      int userId, String type, List<dynamic> images) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      FormData formData = FormData();

      // Add user_id and type to form data
      formData.fields.add(MapEntry('user_id', userId.toString()));
      formData.fields.add(MapEntry('type', type));

      // Add images to form data
      for (int i = 0; i < images.length; i++) {
        String fileName = 'image_$i.jpg';
        formData.files.add(MapEntry(
          'image[$i]',
          await MultipartFile.fromFile(images[i].path, filename: fileName),
        ));
      }

      var response = await _clientDio
          .post(
            ApiConstants.addImagesUrl,
            data: formData,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));

      debugPrint("## Response add images (API handler) : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteAllImagesApi(
      int id, String type) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .delete(
            ApiConstants.deleteAllImagesUrl(id, type),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response delete $type Images (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteImageApi(int imageId) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio
          .delete(
            ApiConstants.deleteImageUrl(imageId),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      debugPrint("## $Response delete Image (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editArticleApi(
      int id, String title, String content) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";

      var response = await _clientDio.post(ApiConstants.editArticleUrl(id),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token,
            },
          ),
          data: {
            "title": title,
            "content": content,
          }).timeout(const Duration(seconds: 50));
      debugPrint("## $Response update article  (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addProgramApi(
    var program,
    int days,
    List<int> playersIDs,
  ) async {
    late Either<String, Response> result;
    FormData formData = FormData.fromMap({
      // ... mapping playersIDs into a list of player_id[] key-value pairs
      ...Map.fromEntries(playersIDs
          .asMap()
          .entries
          .map((entry) => MapEntry('player_id[${entry.key}]', entry.value))),

      // Other key-value pairs
      "name": program.name,
      "type": program.type,
      "categoryId": program.categoryId,
      "days": days,

      // File attachments
      'file': await MultipartFile.fromFile(
        program.file,
      ),
      if (program.imageUrl != '')
        'imageUrl': await MultipartFile.fromFile(
          program.imageUrl,
        ),
    });
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.addProgramUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
            data: formData,
          )
          .timeout(const Duration(seconds: 30));
      debugPrint("## Response add Program (API handler) : Good ");
      debugPrint("## Response add Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editProgramApi(
    var program,
    int days,
    List<int> playersIDs,
  ) async {
    late Either<String, Response> result;
    FormData formData = FormData.fromMap({
      // ... mapping playersIDs into a list of player_id[] key-value pairs
      ...Map.fromEntries(playersIDs
          .asMap()
          .entries
          .map((entry) => MapEntry('player_id[${entry.key}]', entry.value))),

      // Other key-value pairs
      "name": program.name,
      "type": program.type,
      "categoryId": program.categoryId,
      "days": days,

      // File attachments
      'file': await MultipartFile.fromFile(
        program.file,
      ),
      if (program.imageUrl != '')
        'imageUrl': await MultipartFile.fromFile(
          program.imageUrl,
          // filename: "${program.name}_cover"
        ),
    });
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.editProgramUrl(program.id),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
            data: formData,
          )
          .timeout(const Duration(seconds: 25));
      debugPrint("## Response edit Program (API handler) : Good ");
      debugPrint("## Response edit Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getProgramInfoApi(
    int programID,
  ) async {
    late Either<String, Response> result;
    debugPrint(ApiConstants.getProgramInfoUrl(programID));
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .get(
            ApiConstants.getProgramInfoUrl(programID),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 25));
      debugPrint("## Response get program (API handler) : Good ");
      debugPrint("## Response get program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteProgramApi(
    int programID,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .get(
            ApiConstants.deleteProgramUrl(programID),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 25));
      debugPrint("## Response delete program (API handler) : Good ");
      debugPrint("## Response delete program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> assignProgramApi(
    int programId,
    List<int> playersIDs,
    int days,
  ) async {
    late Either<String, Response> result;
    try {
      FormData form = FormData.fromMap({
        ...Map.fromEntries(playersIDs
            .asMap()
            .entries
            .map((entry) => MapEntry('player_id[${entry.key}]', entry.value))),
        'days': days,
      });

      String token = prefsService.getValue(CacheKeys.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.assignProgramUrl(programId),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
            data: form,
          )
          .timeout(const Duration(seconds: 25));
      debugPrint("## Response assign Program (API handler) : Good ");
      debugPrint("## Response assign Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }
}
