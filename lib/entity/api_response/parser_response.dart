import '../../api_error_parser.dart';

abstract class ParserResponse<T, E> {
  T? get data;

  List<ParserMessageEntity<E>> get errors;
}

class ParserResponseEntity<T, E> extends ParserResponse<T, E> {
  @override
  final T? data;
  @override
  final List<ParserMessageEntity<E>> errors;

  ParserResponseEntity(this.data, this.errors);
}

class ParserResponseWithPaginationEntity<T, E> extends ParserResponseEntity<T, E> {
  final Pagination pagination;

  ParserResponseWithPaginationEntity(T data, this.pagination, List<ParserMessageEntity<E>> errors)
      : super(data, errors);
}
