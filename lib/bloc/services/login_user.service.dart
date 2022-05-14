import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

Future<dynamic> loginUser(Map<String, dynamic> userData) async {
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['DEV_BACKEND_URL']!));

  log("runned");
  dio.interceptors.add(CookieManager(PersistCookieJar()));
  log(dio.options.headers.keys.toString());
  log(dio.options.headers.entries.toString());
  log(dio.options.headers['cookies'].toString());

  // If a user dubmitted image send it, else.
  if (userData['image'] != null) {
    userData['image'] = MultipartFile.fromFileSync(userData['image']);
  } else {
    userData.removeWhere((key, value) => value == 'image');
  }

  try {
    Response response = await dio.post('/users/login', data: FormData.fromMap(userData));
    if (response.statusCode == 200) {
      return {
        'status': true,
        'message': "",
      };
    }
  } on DioError catch (e) {
    if (e.response == null) {
      ConnectivityResult value = await Connectivity().checkConnectivity();

      if (value != ConnectivityResult.wifi && value != ConnectivityResult.mobile) {
        return {
          'status': false,
          "message": "No internet connection",
        };
      } else {
        return {
          "status": false,
          "message": "An unexpected error occurred",
        };
      }
    } else {
      return e.response!.data;
    }
  }
}
