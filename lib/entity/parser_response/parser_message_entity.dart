import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

class ParserMessageEntity<T> {
  final String target;
  final ErrorSource? source;
  final String code;
  final T? title;
  final Map<String, dynamic>? meta;

  ParserMessageEntity(
      this.target,
      this.source,
      this.code, {
        this.title,
        this.meta,
      });

  @override
  String toString() {
    return 'ParserMessageEntity{target: $target, source: $source, code: $code, title: $title, meta: $meta}';
  }
}
