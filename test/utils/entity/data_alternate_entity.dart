import 'package:api_error_parser/api_error_parser.dart';

class DataAlternateEntity {
  String accessToken;
  String refreshToken;
  String? challengeName;

  DataAlternateEntity(this.accessToken, this.refreshToken, this.challengeName);

  static DataAlternateEntity fromJson(Map<String, dynamic> json) =>
      DataAlternateEntity(
          json['accessToken'], json['refreshToken'], json['challengeName']);
}
