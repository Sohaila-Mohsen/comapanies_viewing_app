import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    if (token != null) dio.options.headers["Authorization"] = "Bearer $token";
    return await dio.get(url,
        queryParameters: query,
        options:
            Options(receiveTimeout: const Duration(milliseconds: 60 * 100)));
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      //dynamic data,
      Map<String, dynamic>? query,
      String? token}) async {
    /*dio.options.headers = {
      "Content-Type": "application/json",
    };*/
    if (token != null) dio.options.headers["Authorization"] = "Bearer $token";
    debugPrint("before return from dio");
    return await dio
        .post(
      url,
      queryParameters: query,
      data: data,
    )
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  static Future<Response> patchData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String? token}) async {
    if (token != null) dio.options.headers["Authorization"] = "Bearer $token";
    return await dio
        .patch(
          url,
          queryParameters: query,
          data: data,
        )
        .catchError((e) => debugPrint(e));
  }
}
