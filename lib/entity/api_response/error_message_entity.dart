import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

abstract class ErrorMessage {
  String get code;

  String get target;

  ErrorSource? get source;
}

class ErrorMessageEntity extends ErrorMessage {
  @override
  final String code;
  @override
  final String target;
  @override
  final ErrorSourceEntity? source;
  final String message;

  ErrorMessageEntity(this.code, this.target, this.message, {this.source});

  factory ErrorMessageEntity.fromJson(Map<String, dynamic> data) {
    var source = data['source'];
    if (source != null) {
      source = ErrorSourceEntity.fromJson(source);
    }
    return ErrorMessageEntity(data['code'], data['target'], data['message'],
        source: source);
  }
}
