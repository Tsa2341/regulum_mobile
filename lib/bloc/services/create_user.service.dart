import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

Future<dynamic> createUser(Map<String, dynamic> userData) async {
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['DEV_BACKEND_URL']!));

  try {
    Response response = await dio.post('/users/register', data: FormData.fromMap(userData));
    if (response.statusCode == 201) {
      return {
        'status': true,
        'message': "Check your email for the verification",
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
