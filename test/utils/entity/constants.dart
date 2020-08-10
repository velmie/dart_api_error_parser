class Message {
  static const String DEFAULT = "DEFAULT";
  static const String EMPTY_BALANCE = "It seems that user has empty balance";
  static const String PUNCTUATION_ERROR =
      "It seems that the password provided is missing a punctuation character";
  static const String PASSWORD_DO_NOT_MATCH =
      "It seems that the password and password confirmation fields do not match";
  static const String INVALID_PASSWORD =
      "It seems that the password is wrong";
  static const String INVALID_LOGIN =
      "It seems that the login is wrong";
}

class ErrorCode {
  static const String INSUFFICIENT_FUNDS = "insufficient_funds";
  static const String INVALID_PUNCTUATION = "invalid_punctuation";
  static const String INVALID_PASSWORD_CONFIRMATION =
      "invalid_password_confirmation";
  static const String INVALID_PASSWORD = "invalid_password";
  static const String INVALID_LOGIN = "invalid_login";
  static const String UNKNOWN = "unknown_code";
  static const String MIN = "You value is so small";
}

class TARGET {
  static const String FIELD = "field";
  static const String COMMON = "common";
}

class FIELD {
  static const String EMAIL = "email";
  static const String USER_PASSWORD = "userPassword";
}
