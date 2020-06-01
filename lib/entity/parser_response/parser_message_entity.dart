import 'package:api_error_parser/entity/api_response/error_source_entity.dart';

class ParserMessageEntity<T> {
  final String target;
  final ErrorSource source;
  final String code;
  final T message;

  ParserMessageEntity(this.target, this.source, this.code, {this.message});
}
