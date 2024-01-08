import 'package:api_error_parser/api_error_parser.dart';

import '../api_response/parser_response.dart';

abstract class ApiParserResponse<T, E> {
  static ApiParserResponse<T, String> error<T>(Exception error) {
    return ApiParserErrorResponse([
      ParserMessageEntity(
        'unknown target',
        null,
        'unknown code',
        title: error.toString(),
      )
    ]);
  }

  static ApiParserResponse<T, E> errors<T, E>(List<ParserMessageEntity<E>> errors) {
    return ApiParserErrorResponse(errors);
  }

  static ApiParserResponse<T, E> create<T, E>(ParserResponse<T, E> response) {
    if (response.errors.isNotEmpty) {
      return ApiParserErrorResponse(response.errors);
    } else if (response.data != null) {
      if (response is ParserResponseWithPaginationEntity) {
        return ApiParserSuccessResponse(
          response.data as T,
          pagination: (response as ParserResponseWithPaginationEntity).pagination,
        );
      } else {
        return ApiParserSuccessResponse(response.data as T);
      }
    }
    return ApiParserEmptyResponse();
  }
}

class ApiParserEmptyResponse<T, E> extends ApiParserResponse<T, E> {}

class ApiParserSuccessResponse<T, E> extends ApiParserResponse<T, E> {
  final T data;
  final Pagination? pagination;

  ApiParserSuccessResponse(this.data, {this.pagination});
}

class ApiParserErrorResponse<T, E> extends ApiParserResponse<T, E> {
  final List<ParserMessageEntity<E>> errors;

  ApiParserErrorResponse(this.errors);
}
