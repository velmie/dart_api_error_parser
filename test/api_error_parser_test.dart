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
  setUp(() async {
    response = await beforeTest();
  });
  test("message from code", () {
    expect(parser.getMessageFromCode(ErrorCode.INVALID_PUNCTUATION), equals(Message.PUNCTUATION_ERROR));
    expect(parser.getMessageFromCode(ErrorCode.UNKNOWN), equals(Message.DEFAULT));
  });

  test("fits error message", () {
    expect(parser.getFirstMessage(response.errors), equals(Message.EMPTY_BALANCE));
    final errors = response.errors;
    errors.insert(0, response.errors[2]);
    expect(parser.getFirstMessage(response.errors), equals(Message.DEFAULT));
  });

  test("error message", () {
    expect(parser.getMessage(response.errors.last), equals(Message.PASSWORD_DO_NOT_MATCH));
    expect(parser.getMessage(response.errors[2]), equals(Message.DEFAULT));
  });

  test("list errors", () {
    final errors = response.errors;
    final parserErrors = parser.getErrors(response.errors);
    expect(errors[0].code, parserErrors[0].code);
    expect(errors[1].code, parserErrors[1].code);
    expect(errors[2].code, parserErrors[2].code);
    expect(errors[3].code, parserErrors[3].code);

    expect(parserErrors[0].message, Message.EMPTY_BALANCE);
    expect(parserErrors[1].message, Message.PUNCTUATION_ERROR);
    expect(parserErrors[2].message, Message.DEFAULT);
    expect(parserErrors[3].message, Message.PASSWORD_DO_NOT_MATCH);

    expect(parserErrors[0].source != null, true);
    expect(parserErrors[1].source == null, true);
    expect(parserErrors[2].source == null, true);
    expect(parserErrors[3].source != null, true);
  });

  test("parsing", () async {
    response = await beforeTest();
    final parserResponse = parser.getParserResponse(response);
    expect(response.data, parserResponse.data);

    final errors = response.errors;
    final parserErrors = parserResponse.errors;

    expect(errors[0].code, parserErrors[0].code);
    expect(errors[1].code, parserErrors[1].code);
    expect(errors[2].code, parserErrors[2].code);
    expect(errors[3].code, parserErrors[3].code);

    expect(parserErrors[0].message, Message.EMPTY_BALANCE);
    expect(parserErrors[1].message, Message.PUNCTUATION_ERROR);
    expect(parserErrors[2].message, Message.DEFAULT);
    expect(parserErrors[3].message, Message.PASSWORD_DO_NOT_MATCH);

    expect(parserErrors[0].source != null, true);
    expect(parserErrors[1].source == null, true);
    expect(parserErrors[2].source == null, true);
    expect(parserErrors[3].source != null, true);
  });

  test("api parser response", () async {
    response = await beforeTest();
    final errorResponse = parser.parse(response);
    expect(errorResponse is ApiParserErrorResponse, true);

    final errors = response.errors;
    final parserErrors = (errorResponse as ApiParserErrorResponse).errors;

    expect(errors[0].code, parserErrors[0].code);
    expect(errors[1].code, parserErrors[1].code);
    expect(errors[2].code, parserErrors[2].code);
    expect(errors[3].code, parserErrors[3].code);

    expect(parserErrors[0].message, Message.EMPTY_BALANCE);
    expect(parserErrors[1].message, Message.PUNCTUATION_ERROR);
    expect(parserErrors[2].message, Message.DEFAULT);
    expect(parserErrors[3].message, Message.PASSWORD_DO_NOT_MATCH);

    expect(parserErrors[0].source != null, true);
    expect(parserErrors[1].source == null, true);
    expect(parserErrors[2].source == null, true);
    expect(parserErrors[3].source != null, true);

    final emptyResponse = ApiResponseEntity(null, []);
    expect(parser.parse(emptyResponse) is ApiParserEmptyResponse, true);

    final successResponse = ApiResponseEntity<DataEntity>(response.data, []);
    expect(parser.parse(successResponse) is ApiParserSuccessResponse, true);
    expect(successResponse.data != null, true);
    expect(successResponse.data, response.data);
  });
}
