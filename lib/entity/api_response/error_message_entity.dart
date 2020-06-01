import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

abstract class ErrorMessage {
  String get code;

  String get target;

  ErrorSourceEntity get source;

  String get message;
}

class ErrorMessageEntity extends ErrorMessage {
  @override
  final String code;
  @override
  final String target;
  @override
  final ErrorSourceEntity source;
  @override
  final String message;

  ErrorMessageEntity(this.code, this.target, this.message, {this.source});
}
