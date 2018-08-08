import 'dart:convert';
import 'dart:io';

void main() async {
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print('Listen on 8080 port.');
  await listenRequests(server);
}

void listenRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        handleGetRequest(request);
        break;
      case 'POST':
        handlePostRequest(request);
        break;
      case 'HEAD':
        handleHeadRequest(request);
        break;
      case 'PUT':
        handlePutRequest(request);
        break;
      case 'DELETE':
        handleDeleteRequest(request);
        break;
      default:
        unhandleRequest(request);
        break;
    }
  }
}

void unhandleRequest(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.INTERNAL_SERVER_ERROR
    ..writeln('Unhandle request method')
    ..close();
}

void handleGetRequest(HttpRequest request) async {
  print(request.uri);
  request.response
    ..statusCode = HttpStatus.OK
    ..writeln('Request Success!!!')
    ..close();
}

void handlePostRequest(HttpRequest request) async {
  print(request.uri);
  var decode = await request.transform(utf8.decoder);
  for (var item in await decode.toSet()) {
    print(item);
  }
  request.response
    ..statusCode = HttpStatus.OK
    ..write('Request Success!!!')
    ..close();
}

void handleHeadRequest(HttpRequest request) {
  print(request.uri);
  request.response
    ..statusCode = HttpStatus.OK
    ..writeln()
    ..close();
}

void handlePutRequest(HttpRequest request) async {
  print(request.uri);
  var decode = await request.transform(utf8.decoder);
  for (var item in await decode.toSet()) {
    print(item);
  }
  request.response
    ..statusCode = HttpStatus.OK
    ..writeln()
    ..close();
}

void handleDeleteRequest(HttpRequest request) {
  print(request.uri);
  request.response
    ..statusCode = HttpStatus.OK
    ..writeln()
    ..close();
}
