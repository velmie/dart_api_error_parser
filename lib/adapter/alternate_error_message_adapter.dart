import 'package:api_error_parser/adapter/error_message_adapter.dart';
import 'package:api_error_parser/entity/api_response/error_message_entity.dart';
import 'package:api_error_parser/entity/parser_response/parser_message_entity.dart';

import '../entity/api_response/error_message_alternate_entity.dart';

class AlternateErrorMessageAdapter<E> extends ErrorMessageAdapter<E> {
  AlternateErrorMessageAdapter();

  @override
  List<ParserMessageEntity<E>> getErrors(List<ErrorMessage> errors) {
    return errors.map((e) => e as ErrorMessageAlternateEntity).map(
          (error) => ParserMessageEntity(
            error.target,
            error.source,
            error.code,
            title: getMessage(error),
            meta: error.meta
          ),
        )
        .toList();
  }
}
