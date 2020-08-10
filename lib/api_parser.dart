library api_error_parser;

import 'package:api_error_parser/api_error_parser.dart';

class ApiParser<E> {
  ApiParser({
    this.errorMessages,
    this.defaultErrorMessage,
    this.fieldErrorMessages = const {},
  });

  final Map<String, E> errorMessages;
  final E defaultErrorMessage;
  final Map<String, Map<String, E>> fieldErrorMessages;

  ApiParserResponse<T, E> parse<T>(ApiResponse<T> response) {
    return ApiParserResponse.create(getParserResponse(response));
  }

  List<ParserMessageEntity<E>> getErrors(List<ErrorMessage> errors) {
    return errors
        .map((error) => ParserMessageEntity(
            error.target, error.source, error.code,
            message: getMessage(error)))
        .toList();
  }

  E getMessage(ErrorMessage error) {
    if (error.target == "field") {
      final field = error.source.field;
      if (fieldErrorMessages.keys.contains(field)) {
        return getFieldMessageFromCode(field, error.code);
      } else {
        return getMessageFromCode(error.code);
      }
    } else {
      return getMessageFromCode(error.code);
    }
  }

  ParserResponse<T, E> getParserResponse<T>(ApiResponse<T> response) {
    if (response == null) {
      return ParserResponseEntity(null, []);
    } else {
      if (response is ApiResponsePagination) {
        return ParserResponseWithPaginationEntity(
            response.data,
            (response as ApiResponsePagination).pagination,
            getErrors(response.errors ?? []));
      } else {
        return ParserResponseEntity(
            response.data, getErrors(response.errors ?? []));
      }
    }
  }

  E getMessageFromCode(String errorCode) {
    return errorMessages[errorCode] ?? defaultErrorMessage;
  }

  E getFieldMessageFromCode(String field, String errorCode) {
    if (fieldErrorMessages[field].keys.contains(errorCode)) {
      return fieldErrorMessages[field][errorCode];
    } else {
      return getMessageFromCode(errorCode);
    }
  }

  E getFirstMessage(List<ErrorMessage> errors) {
    return getMessage(errors.first);
  }
}
