import '../../api_error_parser.dart';

abstract class ApiResponsePagination<T> extends ApiResponse<List<T>> {
  @override
  List<T>? get data;

  Pagination? get pagination;
}

class ApiResponsePaginationEntity<T> extends ApiResponsePagination<T> {
  @override
  final List<T>? data;
  @override
  final PaginationEntity? pagination;
  @override
  final List<ErrorMessage>? errors;

  ApiResponsePaginationEntity(this.data, this.pagination, this.errors);

  factory ApiResponsePaginationEntity.fromJson(dynamic json, Function? fromJson,
      [ErrorMessage Function(Map<String, dynamic> data) errorFromJson =
          ErrorMessageEntity.fromJson]) {
    if (json is Map<String, dynamic>) {
      return ApiResponsePaginationEntity(
        (json['data'] != null && fromJson != null)
            ? (json['data'] as List)
                .map((dynamic i) => fromJson(i) as T)
                .toList()
            : null,
        json['pagination'] != null
            ? PaginationEntity.fromJson(
                json['pagination'] as Map<String, dynamic>)
            : null,
        ApiResponse.errorsFromJson(json, errorFromJson),
      );
    } else if (json is String) {
      return ApiResponsePaginationEntity(
          null, null, [ErrorMessageEntity.fromMessage(json)]);
    } else {
      return ApiResponsePaginationEntity(
          null, null, [ErrorMessageEntity.empty()]);
    }
  }
}
