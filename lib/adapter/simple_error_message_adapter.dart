import '../api_error_parser.dart';
import 'error_message_adapter.dart';

class SimpleErrorMessageAdapter<E> extends ErrorMessageAdapter<E> {
  SimpleErrorMessageAdapter();

  @override
  List<ParserMessageEntity<E>> getErrors(List<ErrorMessage> errors) {
    return errors
        .map(
          (error) => ParserMessageEntity(
            error.target,
            error.source,
            error.code,
            title: getMessage(error),
          ),
        )
        .toList();
  }
}
