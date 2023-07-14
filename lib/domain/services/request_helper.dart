// ignore_for_file: avoid_annotating_with_dynamic

import 'package:ssrapp/data/models/baseResponse/base_response_model.dart';
import 'package:ssrapp/domain/services/request_handler.dart';
import 'package:ssrapp/utils/static_data.dart';

abstract class RequestHelper {
  static final _rh = RequestHandler();

  // static Future<T> getSimpleObject<T>(
  //   String path,
  // ) async {
  //   final response = await _rh.get(path);

  //   return response.data as T;
  // }

  // static Future<List<T>> getListOfSimpleObjects<T>(
  //   String path,
  // ) async {
  //   final response = await _rh.get(path);

  //   final list =
  //       (response.data as List<dynamic>).map((dynamic e) => e as T).toList();

  //   return list;
  // }

  static Future<T> getObject<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _rh.get<dynamic>(
      path,
      baseUrl: StaticData.apiUrl,
      queryParameters: queryParameters,
    );

    final baseRes =
        BaseResponseRepository.fromJson(response.data as Map<String, dynamic>);

    final obj = fromJson(baseRes.data as Map<String, dynamic>);

    return obj;
  }

  static Future<List<T>> getListOfObjects<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _rh.get<dynamic>(
      path,
      baseUrl: StaticData.apiUrl,
      queryParameters: queryParameters,
    );

    final baseRes =
        BaseResponseRepository.fromJson(response.data as Map<String, dynamic>);

    final list = (baseRes.data as List<dynamic>)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>))
        .toList();

    return list;
  }
}
