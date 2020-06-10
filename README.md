# API Parser

[![License: MIT](https://img.shields.io/badge/license-BSD-purple.svg)](https://opensource.org/licenses/BSD-3-Clause)

A library for parsing responses from api and converting error codes into messages for the user.

- [API response description](#api-response-description)
- [Version](#version)
- [How it works](#how-it-works)
- [License](#license)

# API response description
**It is assumed that the response will correspond to the following specifications.**

Each error from server should be in next format:

- ***code***: a unique code of an error. Used to identify error from the dictionary.
- ***target***: some sort of error scope
- ***field*** - the error related to certain field
- ***common*** - the error related to whole request
- ***message (OPTIONAL)***: the error message for developers (use it only for debug purposes)
- ***source (OPTIONAL)***: a container for additional data. Arbitrary structure: ( field: resource object attribute name. Required if target set to field. )

Example:
```json
{
"data": [
     {
       "id": 1,
       "userName": "Tom",
       "age": 21
     },
     {
       "id": 2,
       "userName": "Bob",
       "age": 22
     }
   ],
  "errors": [
    {
      "code": "insufficient_funds",
      "target": "common",
      "message": "Hi Nick, it seems that user has empty balance"
    },
    {
      "code": "invalid_punctuation",
      "target": "field",
      "source": {
        "field": "userPassword"
      },
      "message": "Hi Vova, it seems that the password provided is missing a punctuation character"
    },
    {
      "code": "invalid_password_confirmation",
      "target": "field",
      "source": {
        "field": "userPassword",
        "someAdditionalData": "bla bla bla"
      },
      "message": "Hi Lesha, it seems that the password and password confirmation fields do not match"
    }
  ]
 }
```
####Pagination
In server response should be pagination object in the next format:

- ***currentPage***: current returned page
- ***totalPage***: total pages amount
- ***totlaRecord***: total record amount
- ***limit***: number of items per page

Example:
```json
{
  "data": [
    {
      "id": 1
    },
    {
      "id": 2
    }
  ],
  "pagination": {
    "currentPage": 3,
    "totalPage": 10,
    "totalRecord": 92,
    "limit": 10
  }
}
```
# Version
0.04

# How it works
The library provides ready-made interfaces for server responses to which the object passed to the parmer must correspond.

To initialize the ErrorParser, you must pass to the constructor:
  errorMessages: 
- `Map<String, E>` - the key is the error code and the value of the displayed message
- `defaultErrorMessage`: E - message of unknown errors


**Api parser description:**
- `parse(response: ApiParserResponse<T>)` - returns `ApiParserResponse` in the states: success , empty or error
- `getParserResponse(response: ApiResponse<T>)` - parses the server response object and returns the processed result
- `getErrors(errors: List<ErrorMessage>)` - returns a list of processed errors
- `getMessageFromCode(errorCode: String)` - returns the message associated with this error code
- `getMessage(errorMessage: ErrorMessage)` - returns the processed error
- `getFirstMessage(errors: List<ErrorMessage>)` - returns the first processed error from the list

Dart
-------------

```Dart
final apiParser = ApiParser({
                  CODE.ERROR_CODE: Message.ERROR_MESSAGE,
                }, Message.DEFAULT);
               
final ParserResponse<UserEntity> parserResponse = apiParser.getParserResponse(serverResponse);
                             
final ApiParserResponse<UserEntity> apiParserResponse = apiParser.parse(serverResponse); 

switch (apiParserResponse.runtimeType) {
    case  ApiParserEmptyResponse: {
      //do something
      break;
    }
    case  ApiParserErrorResponse: {
      //do something
      break;
    }
    case  ApiParserSuccessResponse: {
      //do something
      break;
    }
}
                            
```

# License
ApiParser is released under the MIT license. See [LICENSE](/LICENSE) for details.
