import 'dart:convert';
import 'dart:io';

import 'package:api_error_parser/adapter/alternate_error_message_adapter.dart';
import 'package:api_error_parser/adapter/simple_error_message_adapter.dart';
import 'package:api_error_parser/api_error_parser.dart';
import 'package:api_error_parser/entity/api_response/error_message_alternate_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/entity/constants.dart';
import 'utils/entity/data_alternate_entity.dart';
import 'utils/entity/data_entity.dart';

ApiParser<String> parser = ApiParser(
  adapters: {
    ErrorMessageEntity: SimpleErrorMessageAdapter(),
    ErrorMessageAlternateEntity: AlternateErrorMessageAdapter()
  },
  errorMessages: {
    ErrorCode.INSUFFICIENT_FUNDS: Message.EMPTY_BALANCE,
    ErrorCode.INVALID_PASSWORD_CONFIRMATION: Message.PASSWORD_DO_NOT_MATCH,
    ErrorCode.INVALID_PUNCTUATION: Message.PUNCTUATION_ERROR,
    ErrorCode.INVALID_PASSWORD: Message.INVALID_PASSWORD,
    ErrorCode.INVALID_LOGIN: Message.INVALID_LOGIN
  },
  fieldErrorMessages: {
    FIELD.EMAIL: {
      ErrorCode.INVALID_PASSWORD_CONFIRMATION: Message.PASSWORD_DO_NOT_MATCH,
    },
    FIELD.USER_PASSWORD: {
      ErrorCode.INVALID_PUNCTUATION: Message.PUNCTUATION_ERROR
    },
    FIELD.EMAIL_LENGTH: {ErrorCode.MIN: Message.EMAIL_LENGTH_MESSAGE}
  },
  defaultErrorMessage: Message.DEFAULT,
  //default403ErrorMessage: Message.DEFAULT_403_MESSAGE,
);

late ApiResponseEntity<DataEntity> response;
late ApiResponseEntity<DataAlternateEntity> responseAlternate;

Future<ApiResponseEntity<DataEntity>> beforeTest() async {
  final file = File('test_resources/test.json');
  var jsonData = await file.readAsString();
  var decode = json.decode(jsonData);
  return ApiResponseEntity<DataEntity>.fromJson(
    decode,
    DataEntity.fromJson,
  );
}

Future<ApiResponseEntity<DataAlternateEntity>> beforeTestAlternate() async {
  final file = File('test_resources/test_alternate.json');
  var jsonData = await file.readAsString();
  var decode = json.decode(jsonData);
  return ApiResponseEntity<DataAlternateEntity>.fromJson(decode,
      DataAlternateEntity.fromJson, ErrorMessageAlternateEntity.fromJson);
}

void main() {
  setUp(() async {
    response = await beforeTest();
    responseAlternate = await beforeTestAlternate();
  });
  test("message from code", () async {
    expect(
      parser.getMessageFromCode(ErrorCode.INVALID_PUNCTUATION),
      equals(Message.PUNCTUATION_ERROR),
    );
    expect(
      parser.getMessageFromCode(ErrorCode.UNKNOWN),
      equals(Message.DEFAULT),
    );
  });

  test("fits error message", () {
    final errors = response.errors;
    if (errors != null) {
      expect(
        parser.getFirstMessage(errors),
        equals(Message.EMPTY_BALANCE),
      );
      errors.insert(0, errors[2]);
      expect(
        parser.getFirstMessage(errors),
        equals(Message.DEFAULT),
      );
    }
  });

  test("error message", () {
    final errors = response.errors;
    if (errors != null) {
      expect(
          parser.getMessage(errors.last),
          equals(
            Message.INVALID_LOGIN,
          ));
      expect(
        parser.getMessage(errors[2]),
        equals(Message.DEFAULT),
      );
    }
  });

  test("list errors", () {
    final errors = response.errors;

    if (errors != null) {
      final parserErrors = parser.getErrors(ErrorMessageEntity, errors);
      expect(errors[0].code, parserErrors[0].code);
      expect(errors[1].code, parserErrors[1].code);
      expect(errors[2].code, parserErrors[2].code);
      expect(errors[3].code, parserErrors[3].code);
      expect(errors[4].code, parserErrors[4].code);
      expect(errors[5].code, parserErrors[5].code);

      expect(parserErrors[0].title, Message.EMPTY_BALANCE);
      expect(parserErrors[1].title, Message.PUNCTUATION_ERROR);
      expect(parserErrors[2].title, Message.DEFAULT);
      expect(parserErrors[3].title, Message.PASSWORD_DO_NOT_MATCH);
      expect(parserErrors[4].title, Message.INVALID_PASSWORD);
      expect(parserErrors[5].title, Message.INVALID_LOGIN);

      expect(parserErrors[0].source == null, true);
      expect(parserErrors[1].source != null, true);
      expect(parserErrors[2].source != null, true);
      expect(parserErrors[3].source != null, true);
      expect(parserErrors[4].source != null, true);
      expect(parserErrors[5].source != null, true);
    }
  });

  test("list errors alternate", () {
    final errorsAlternate = responseAlternate.errors;

    if (errorsAlternate != null) {
      final parserErrors =
          parser.getErrors(ErrorMessageAlternateEntity, errorsAlternate);
      expect(errorsAlternate[0].code, parserErrors[0].code);

      expect(parserErrors[0].title, Message.EMAIL_LENGTH_MESSAGE);

      expect(parserErrors[0].source != null, true);

      expect(parserErrors[0].source?.field, FIELD.EMAIL_LENGTH);
    }
  });

  test("parsing", () async {
    response = await beforeTest();
    final parserResponse =
        parser.getParserResponse(ErrorMessageEntity, response);
    expect(response.data, parserResponse.data);

    final errors = response.errors;
    final parserErrors = parserResponse.errors;
    if (errors != null) {
      expect(errors[0].code, parserErrors[0].code);
      expect(errors[1].code, parserErrors[1].code);
      expect(errors[2].code, parserErrors[2].code);
      expect(errors[3].code, parserErrors[3].code);
      expect(errors[4].code, parserErrors[4].code);
      expect(errors[5].code, parserErrors[5].code);
    }
    expect(parserErrors[0].title, Message.EMPTY_BALANCE);
    expect(parserErrors[1].title, Message.PUNCTUATION_ERROR);
    expect(parserErrors[2].title, Message.DEFAULT);
    expect(parserErrors[3].title, Message.PASSWORD_DO_NOT_MATCH);
    expect(parserErrors[4].title, Message.INVALID_PASSWORD);
    expect(parserErrors[5].title, Message.INVALID_LOGIN);

    expect(parserErrors[0].source == null, true);
    expect(parserErrors[1].source != null, true);
    expect(parserErrors[2].source != null, true);
    expect(parserErrors[3].source != null, true);
    expect(parserErrors[4].source != null, true);
    expect(parserErrors[5].source != null, true);
  });

  test("api parser response", () async {
    response = await beforeTest();
    final errorResponse = parser.parse(ErrorMessageEntity, response);
    expect(errorResponse is ApiParserErrorResponse, true);

    final errors = response.errors;
    final parserErrors = (errorResponse as ApiParserErrorResponse).errors;

    if (errors != null) {
      expect(errors[0].code, parserErrors[0].code);
      expect(errors[1].code, parserErrors[1].code);
      expect(errors[2].code, parserErrors[2].code);
      expect(errors[3].code, parserErrors[3].code);
      expect(errors[4].code, parserErrors[4].code);
      expect(errors[5].code, parserErrors[5].code);
    }

    expect(parserErrors[0].title, Message.EMPTY_BALANCE);
    expect(parserErrors[1].title, Message.PUNCTUATION_ERROR);
    expect(parserErrors[2].title, Message.DEFAULT);
    expect(parserErrors[3].title, Message.PASSWORD_DO_NOT_MATCH);
    expect(parserErrors[4].title, Message.INVALID_PASSWORD);
    expect(parserErrors[5].title, Message.INVALID_LOGIN);

    expect(parserErrors[0].source == null, true);
    expect(parserErrors[1].source != null, true);
    expect(parserErrors[2].source != null, true);
    expect(parserErrors[3].source != null, true);
    expect(parserErrors[4].source != null, true);
    expect(parserErrors[5].source != null, true);

    final emptyResponse = ApiResponseEntity(null, []);
    expect(
        parser.parse(ErrorMessageEntity, emptyResponse)
            is ApiParserEmptyResponse,
        true);

    final successResponse = ApiResponseEntity<DataEntity>(
      response.data,
      [],
    );
    expect(
      parser.parse(ErrorMessageEntity, successResponse)
          is ApiParserSuccessResponse,
      true,
    );
    expect(successResponse.data != null, true);
    expect(successResponse.data, response.data);
  });
}
