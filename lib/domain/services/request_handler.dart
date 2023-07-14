// ignore_for_file: avoid_annotating_with_dynamic, avoid_catches_without_on_clauses, no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:ssrapp/utils/static_data.dart';

class RequestHandler {
  factory RequestHandler() {
    final handler = _singleton;

    return handler;
  }

  RequestHandler._init() {
    _dio = _createDio();
  }

  static final RequestHandler _singleton = RequestHandler._init();

  Dio? _dio;

  // ignore: member-ordering-extended

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    String? baseUrl,
  }) async {
    // late Response<T> res;

    _dio?.options = _dio!.options.copyWith(
      baseUrl: baseUrl ?? StaticData.apiUrl,
    );

    final res = await _dio!.get<T>(
      path,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      // options: await _getOptions(options),
      queryParameters: queryParameters,
    );

    // final base = BaseResponseRepository.fromJson(
    //   res.data!,
    // );

    return res;
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    _dio?.options = _dio!.options.copyWith(
      baseUrl: baseUrl ?? StaticData.apiUrl,
    );

    final res = await _dio!.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      // options: await _getOptions(options),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    // final base = BaseResponseRepository.fromJson(
    //   res.data!,
    // );

    return res;
  }

  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: StaticData.apiUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 40),
      ),
    );
  }
}
