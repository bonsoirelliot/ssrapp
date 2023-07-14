// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:ssrapp/data/exceptions/response_parse_exception.dart';
import 'package:ssrapp/data/exceptions/success_false.dart';

part 'base_response_model.g.dart';

@JsonSerializable()

/// Модель ответа на запрос
class BaseResponseRepository {
  const BaseResponseRepository({
    required this.data,
    required this.success,
    this.code,
    this.message,
  });

  factory BaseResponseRepository.fromJson(Map<String, dynamic> json) {
    if (json['success'] is! bool) {
      throw ResponseParseException('Ответ от сервера не содержит success');
    }

    // if ((json['code'] as int?) == 403) {
    //   throw AccessError(json['message'] as String? ?? 'Ошибка доступа');
    // }

    if (json['success'] == false) {
      throw SuccessFalse(json['message'] as String? ?? 'Произошла ошибка');
    }

    try {
      final res = _$BaseResponseRepositoryFromJson(json);

      return res;
    } catch (e) {
      throw ResponseParseException('BaseResponseRepository: $e');
    }
  }

  factory BaseResponseRepository.empty() {
    return const BaseResponseRepository(
      data: <dynamic>[],
      success: true,
    );
  }

  /// данные в ответе на запрос
  /// чаще всего бывает [Map] или [List]
  final dynamic data;

  /// результат выполнения запроса
  final bool success;

  /// некое сообщение
  /// обычно присутствует если [success] == false
  final String? message;

  final int? code;

  Map<String, dynamic> toJson() => _$BaseResponseRepositoryToJson(this);
}
