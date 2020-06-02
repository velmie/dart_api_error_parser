import 'package:api_error_parser/entity/api_response/error_message_entity.dart';

abstract class ApiResponse<T> {
  T get data;

  List<ErrorMessage> get errors;
}

class ApiResponseEntity<T> extends ApiResponse<T> {
  @override
  final T data;
  @override
  final List<ErrorMessageEntity> errors;

  ApiResponseEntity(this.data, this.errors);

  factory ApiResponseEntity.fromJson(Map<String, dynamic> json, Function fromJson) {
    final dataJson = json['data'];
    List<ErrorMessageEntity> list = (json['errors'] as List).map((i) => ErrorMessageEntity.fromJson(i)).toList();
    return ApiResponseEntity<T>(fromJson(dataJson), list);
  }
}
