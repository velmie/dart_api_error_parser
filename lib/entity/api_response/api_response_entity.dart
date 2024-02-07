import 'dart:math';

import 'package:api_error_parser/entity/api_response/error_message_entity.dart';

abstract class ApiResponse<T> {
  T? get data;

  List<ErrorMessage>? get errors;

  static List<ErrorMessage> errorsFromJson(Map<String, dynamic>? json,
      ErrorMessage Function(Map<String, dynamic> data) errorFromJson) {
    var list = <ErrorMessage>[];
    if (json?['errors'] != null) {
      list = (json!['errors'] as List)
          .map((dynamic i) => errorFromJson(i))
          .toList();
    }
    return list;
  }
}

class ApiResponseEntity<T> extends ApiResponse<T> {
  @override
  final T? data;
  @override
  final List<ErrorMessage>? errors;

  ApiResponseEntity(this.data, this.errors);

  factory ApiResponseEntity.fromJson(dynamic response, Function? fromJson,
      [ErrorMessage Function(Map<String, dynamic> data) errorFromJson =
          ErrorMessageEntity.fromJson]) {
      if (response is Map<String, dynamic>) {
        return ApiResponseEntity(
            (response['data'] != null && fromJson != null)
                ? fromJson(response['data']) as T?
                : null,
            ApiResponse.errorsFromJson(response, errorFromJson));
      } else if (response?.data is Map<String, dynamic>) {
        final json = response.data as Map<String, dynamic>;
        return ApiResponseEntity(
            (json['data'] != null && fromJson != null)
                ? fromJson(json['data']) as T?
                : null,
            ApiResponse.errorsFromJson(json, errorFromJson));
      } else {
        return ApiResponseEntity(
            response as T?,
            ApiResponse.errorsFromJson(
                response as Map<String, dynamic>, errorFromJson));
      }
  }
}
