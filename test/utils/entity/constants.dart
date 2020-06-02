class Message {
  static const String DEFAULT = "DEFAULT";
  static const String EMPTY_BALANCE = "It seems that user has empty balance";
  static const String PUNCTUATION_ERROR = "It seems that the password provided is missing a punctuation character";
  static const String PASSWORD_DO_NOT_MATCH = "It seems that the password and password confirmation fields do not match";
}

class ErrorCode {
  static const String INSUFFICIENT_FUNDS = "insufficient_funds";
  static const String INVALID_PUNCTUATION = "invalid_punctuation";
  static const String INVALID_PASSWORD_CONFIRMATION = "invalid_password_confirmation";
  static const String UNKNOWN = "unknown_code";
}

class TARGET {
  static const String FIELD = "field";
  static const String COMMON = "common";
}
