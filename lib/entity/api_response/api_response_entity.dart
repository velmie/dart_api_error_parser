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

  factory ApiResponseEntity.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    final dataJson = json['data'];
    final errorsJson = json['errors'];
    List<ErrorMessageEntity> list;
    if (errorsJson != null) {
      list = (json['errors'] as List)
          .map((i) => ErrorMessageEntity.fromJson(i))
          .toList();
    }
    T data;
    if (dataJson != null && fromJson != null) {
      data = fromJson(dataJson);
    }
    return ApiResponseEntity<T>(data, list);
  }
}
