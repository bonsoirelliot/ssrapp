// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseRepository _$BaseResponseRepositoryFromJson(
        Map<String, dynamic> json) =>
    BaseResponseRepository(
      data: json['data'],
      success: json['success'] as bool,
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BaseResponseRepositoryToJson(
        BaseResponseRepository instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
    };
