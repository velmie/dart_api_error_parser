import 'package:api_error_parser/entity/parser_response/parser_message_entity.dart';

import '../entity/api_response/error_message_entity.dart';


abstract class ErrorMessageAdapter<E> {

  late E Function(ErrorMessage errors) getMessage;

  List<ParserMessageEntity<E>> getErrors(List<ErrorMessage> errors);
}