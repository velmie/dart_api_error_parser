abstract class ErrorSource {
  String get field;
}

class ErrorSourceEntity extends ErrorSource {
  @override
  final String field;

  ErrorSourceEntity(this.field);
}
