import 'package:api_error_parser/api_error_parser.dart';

abstract class ApiParserResponse<T, E> {
  ApiParserResponse<T, String> error<T>(Exception error) {
    return ApiParserErrorResponse([ParserMessageEntity("unknown target", null, "unknown code", message: error.toString())]);
  }

  ApiParserResponse<T, E> errors<T, E>(List<ParserMessageEntity<E>> errors) {
    return ApiParserErrorResponse(errors);
  }

  ApiParserResponse<T, E> success<T, E>(ParserResponseEntity<T, E> response) {
    if (response.errors.isNotEmpty) {
      return ApiParserErrorResponse(response.errors);
    } else if (response.data != null) {
      return ApiParserSuccessResponse(response as T);
    }
    return ApiParserEmptyResponse();
  }
}

class ApiParserEmptyResponse<T, E> extends ApiParserResponse<T, E> {}

class ApiParserSuccessResponse<T, E> extends ApiParserResponse<T, E> {
  final T data;

  ApiParserSuccessResponse(this.data);
}

class ApiParserErrorResponse<T, E> extends ApiParserResponse<T, E> {
  final List<ParserMessageEntity<E>> listOfError;

  ApiParserErrorResponse(this.listOfError);
}
