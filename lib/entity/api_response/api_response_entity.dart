import 'package:api_error_parser/entity/api_response/error_message_entity.dart';

abstract class ApiResponse<T> {
  T get data;

  List<ErrorMessageEntity> get errors;
}

class ApiResponseEntity<T> extends ApiResponse {
  @override
  final T data;
  @override
  final List<ErrorMessageEntity> errors;

  ApiResponseEntity(this.data, this.errors);
}
