abstract class ErrorSource {
  String get field;
}

class ErrorSourceEntity extends ErrorSource {
  @override
  String field = "";

  ErrorSourceEntity(this.field);

  ErrorSourceEntity.fromJson(Map<String, dynamic> data) {
    field = data['field'];
  }

  @override
  String toString() {
    return 'ErrorSourceEntity{field: $field}';
  }
}
