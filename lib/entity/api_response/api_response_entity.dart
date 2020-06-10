import 'package:api_error_parser/entity/api_response/error_message_entity.dart';

abstract class ApiResponse<T> {
  T get data;

  List<ErrorMessage> get errors;

  static List<ErrorMessageEntity> errorsFromJson(Map<String, dynamic> json) {
    final errorsJson = json['errors'];
    List<ErrorMessageEntity> list;
    if (errorsJson != null) {
      list = (json['errors'] as List).map((i) => ErrorMessageEntity.fromJson(i)).toList();
    }
    return list;
  }
}

class ApiResponseEntity<T> extends ApiResponse<T> {
  @override
  final T data;
  @override
  final List<ErrorMessageEntity> errors;

  ApiResponseEntity(this.data, this.errors);

  factory ApiResponseEntity.fromJson(Map<String, dynamic> json, Function fromJson) =>
      ApiResponseEntity((json['data'] != null && fromJson != null) ? fromJson(json['data']) : null, ApiResponse.errorsFromJson(json));
}
