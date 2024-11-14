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
  final String? message;

  ErrorMessageEntity(this.code, this.target, this.message, {this.source});

  factory ErrorMessageEntity.fromJson(Map<String, dynamic> data) {
    var source = data['source'];
    if (source != null) {
      if (source is String) {
        source = ErrorSourceEntity(source);
      } else {
        source = ErrorSourceEntity.fromJson(source);
      }
    }
    return ErrorMessageEntity(data['code'], data['target'], data['message'],
        source: source);
  }

  factory ErrorMessageEntity.fromMessage(String message) {
    return ErrorMessageEntity(
      "",
      "",
      message,
    );
  }

  factory ErrorMessageEntity.empty() {
    return ErrorMessageEntity(
      "",
      "",
      "",
    );
  }
}
