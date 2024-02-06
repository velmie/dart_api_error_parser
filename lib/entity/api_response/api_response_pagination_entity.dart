import '../../api_error_parser.dart';

abstract class ApiResponsePagination<T> extends ApiResponse<List<T>> {
  @override
  List<T>? get data;

  Pagination get pagination;
}

class ApiResponsePaginationEntity<T> extends ApiResponsePagination<T> {
  @override
  final List<T>? data;
  @override
  final PaginationEntity pagination;
  @override
  final List<ErrorMessage>? errors;

  ApiResponsePaginationEntity(this.data, this.pagination, this.errors);

  factory ApiResponsePaginationEntity.fromJson(
      Map<String, dynamic> json, Function? fromJson,
      {ErrorMessage Function(Map<String, dynamic> data) errorFromJson =
          ErrorMessageEntity.fromJson}) {
    return ApiResponsePaginationEntity(
      (json['data'] != null && fromJson != null)
          ? (json['data'] as List).map((dynamic i) => fromJson(i) as T).toList()
          : null,
      PaginationEntity.fromJson(json['pagination'] as Map<String, dynamic>),
      ApiResponse.errorsFromJson(json, errorFromJson),
    );
  }
}
