import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/config.dart';

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}

class ApiService {
  const ApiService._();

  static final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: Config.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    );

  static Future<String> request(
    String path, {
    Method method = Method.get,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
    FormData? formData,
  }) async {
    final newHeaders = {
      HttpHeaders.authorizationHeader: Config.clientID,
      HttpHeaders.contentTypeHeader: formData != null
          ? Headers.multipartFormDataContentType
          : Headers.jsonContentType,
      ...?headers,
    };
    Response<Object?> response = await _dio.request<Object?>(
      path,
      data: body ?? formData,
      queryParameters: queryParameters,
      options: Options(
        method: method.name,
        headers: newHeaders,
      ),
    );

    print('''
------------------------------------------------------------
        === Response (${response.statusCode}) === 
        === Url: ${response.realUri} ===
        === Method (${response.requestOptions.method}) ===
        === Data: ${response.data}
------------------------------------------------------------''');

    return jsonEncode(response.data);
  }
}
