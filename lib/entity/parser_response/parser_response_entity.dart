import 'package:api_error_parser/entity/parser_response/parser_message_entity.dart';

class ParserResponseEntity<T, E> {
  final T data;
  final List<ParserMessageEntity<E>> errors;

  ParserResponseEntity(this.data, this.errors);
}
