import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

Future<dynamic> updateUser(Map<String, dynamic> userData) async {
  Box userBox = Hive.box("user");
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['DEV_BACKEND_URL']!));

  log("runned");
  dio.options.headers["Authorization"] = "Bearer ${userBox.get('user')}";
  log("Bearer ${userBox.get('token')}");

  // If a user dubmitted image send it, else.
  if (userData['image'] != null) {
    userData['image'] = MultipartFile.fromFileSync(userData['image']);
  } else {
    userData.removeWhere((key, value) => value == 'image');
  }

  try {
    Response response = await dio.patch('/users', data: FormData.fromMap(userData));
    if (response.statusCode == 200) {
      return true;
    }
  } on DioError catch (e) {
    if (e.response == null) {
      ConnectivityResult value = await Connectivity().checkConnectivity();

      if (value != ConnectivityResult.wifi && value != ConnectivityResult.mobile) {
        return {"message": "No internet connection"};
      } else {
        return {"message": "An unexpected error occurred"};
      }
    } else {
      return e.response!.data;
    }
  }
}
