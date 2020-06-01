library api_error_parser;

class ApiParser<E> {
  ApiParser(this.errorMessages, this.defaultErrorMessage);

  final Map<String, E> errorMessages;
  final E defaultErrorMessage;

}
