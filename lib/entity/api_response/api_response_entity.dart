import 'package:api_error_parser/entity/api_response/error_message_entity.dart';

abstract class ApiResponse<T> {
  T? get data;

  List<ErrorMessage>? get errors;

  static List<ErrorMessageEntity> errorsFromJson(Map<String, dynamic>? json) {
    var list = <ErrorMessageEntity>[];
    if (json?['errors'] != null) {
      list =
          (json!['errors'] as List).map((dynamic i) => ErrorMessageEntity.fromJson(i as Map<String, dynamic>)).toList();
    }
    return list;
  }
}

abstract class ApiResponseNew<T> {
  T? get data;

  List<ErrorMessage>? get errors;

  static List<ErrorMessageEntity> errorsFromJson(dynamic json) {
    final list = <ErrorMessageEntity>[];
    if (json != null) {
      var title = '';
      try {
        title = json.title as String;
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {}
      list.add(
        ErrorMessageEntity(
          (json.statusCode as int).toString(),
          json.statusMessage as String,
          title,
        ),
      );
    }
    return list;
  }
}

class ApiResponseEntity<T> extends ApiResponse<T> {
  @override
  final T? data;
  @override
  final List<ErrorMessageEntity>? errors;

  ApiResponseEntity(this.data, this.errors);

  factory ApiResponseEntity.fromJson(dynamic response, Function? fromJson) {
    try {
      if (response is Map<String, dynamic>) {
        return ApiResponseEntity(
          (response['data'] != null && fromJson != null) ? fromJson(response['data']) as T? : null,
          ApiResponse.errorsFromJson(response),
        );
      } else if (response?.data is Map<String, dynamic>) {
        final newJson = response.data as Map<String, dynamic>;
        return ApiResponseEntity(
          (newJson['data'] != null && fromJson != null) ? fromJson(newJson['data']) as T? : null,
          ApiResponse.errorsFromJson(newJson),
        );
      } else {
        return ApiResponseEntity(
          response as T?,
          ApiResponseNew.errorsFromJson(response),
        );
      }
    } on FormatException {
      if (response.error['source'] != null && response.error['target'] == 'field') {
        return ApiResponseEntity(
          null,[]
          //ErrorConverter.errorsFromInvalidJson(response!.data as Map<String, dynamic>),
        );
      }
      return ApiResponseEntity(
        null,
        ApiResponseNew.errorsFromJson(response),
      );
    }
  }
}