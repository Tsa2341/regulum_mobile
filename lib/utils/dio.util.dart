import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['DEV_BACKEND_URL']!));
