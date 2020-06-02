library api_error_parser;

import 'package:api_error_parser/api_error_parser.dart';

class ApiParser<E> {
  ApiParser(this.errorMessages, this.defaultErrorMessage);

  final Map<String, E> errorMessages;
  final E defaultErrorMessage;

  ApiParserResponse<T, E> parse<T>(ApiResponse<T> response) {
    return ApiParserResponse.create(getParserResponse(response));
  }

  List<ParserMessageEntity<E>> getErrors(List<ErrorMessage> errors) {
    return errors.map((error) => ParserMessageEntity(error.target, error.source, error.code, message: getMessageFromCode(error.code))).toList();
  }

  ParserResponseEntity<T, E> getParserResponse<T>(ApiResponse<T> response) {
    if (response == null) {
      return ParserResponseEntity(null, []);
    } else {
      return ParserResponseEntity(response.data, getErrors(response.errors ?? []));
    }
  }

  E getMessageFromCode(String errorCode) {
    return errorMessages[errorCode] ?? defaultErrorMessage;
  }

  E getMessage(ErrorMessage errorMessage) {
    return errorMessages[errorMessage.code] ?? defaultErrorMessage;
  }

  E getFirstMessage(List<ErrorMessage> errors) {
    return getMessage(errors.first);
  }
}
