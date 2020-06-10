abstract class Pagination {
  int get currentPage;

  int get totalPage;

  int get totalRecord;

  int get limit;
}

class PaginationEntity extends Pagination {
  @override
  final int currentPage;
  @override
  final int totalPage;
  @override
  final int totalRecord;
  @override
  final int limit;

  PaginationEntity(this.currentPage, this.totalPage, this.totalRecord, this.limit);

  factory PaginationEntity.fromJson(Map<String, dynamic> data) =>
      PaginationEntity(data['currentPage'], data['totalPage'], data['totalRecord'], data['limit']);

  @override
  String toString() {
    return "{${super.toString()} currentPage = $currentPage, totalPage = $totalPage, totalRecord = $totalRecord, limit = $limit}";
  }
}
