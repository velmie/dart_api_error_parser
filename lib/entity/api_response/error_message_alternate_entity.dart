import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

import 'error_message_entity.dart';

class ErrorMessageAlternateEntity extends ErrorMessage {
  String title;
  String? details;
  @override
  final String code;
  @override
  final String target;
  @override
  final ErrorSourceEntity? source;
  final Map<String, dynamic>? meta;

  ErrorMessageAlternateEntity(
      this.title, this.details, this.code, this.target, this.source, this.meta);

  static ErrorMessageAlternateEntity fromJson(Map<String, dynamic> json) =>
      ErrorMessageAlternateEntity(json['title'], json['details'], json['code'],
          json['target'], ErrorSourceEntity(json['source']), json['meta']);
}
