import 'dart:convert';
import 'dart:io';

import 'package:api_error_parser/api_error_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/entity/constants.dart';
import 'utils/entity/data_entity.dart';

ApiParser<String> parser = ApiParser({
  ErrorCode.INSUFFICIENT_FUNDS: Message.EMPTY_BALANCE,
  ErrorCode.INVALID_PASSWORD_CONFIRMATION: Message.PASSWORD_DO_NOT_MATCH,
  ErrorCode.INVALID_PUNCTUATION: Message.PUNCTUATION_ERROR
}, Message.DEFAULT);

ApiResponseEntity<DataEntity> response;

Future<ApiResponseEntity<DataEntity>> beforeTest() async {
  final file = File('test_resources/test.json');
  var jsonData = await file.readAsString();
  var decode = json.decode(jsonData);
  return ApiResponseEntity<DataEntity>.fromJson(decode, DataEntity.fromJson);
}

void main() {

  test('preparing test', () async {
    response = await beforeTest();
    var l = response;
  });
}
