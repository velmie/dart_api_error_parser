import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

abstract class ErrorMessage {
  String get code;

  String get target;

  ErrorSource? get source;

  String? get title;

  Map<String, dynamic>? get meta;
}

class ErrorMessageEntity extends ErrorMessage {
  @override
  final String code;
  @override
  final String target;
  @override
  final ErrorSourceEntity? source;
  @override
  final String? title;
  @override
  final Map<String, dynamic>? meta;

  ErrorMessageEntity(
      this.code,
      this.target,
      this.title, {
        this.source,
        this.meta,
      });

  factory ErrorMessageEntity.fromJson(Map<String, dynamic> data) {
    dynamic source = data['source'];
    final meta = data['meta'] as Map<String, dynamic>?;
    if (source != null) {
      if (source is String) {
        source = ErrorSourceEntity(source);
      } else {
        source = ErrorSourceEntity.fromJson(source as Map<String, dynamic>);
      }
    }

    return ErrorMessageEntity(
      data['code'] as String,
      (data['target'] ?? '??') as String,
      data['title'] as String?,
      source: source as ErrorSourceEntity?,
      meta: meta,
    );
  }
}