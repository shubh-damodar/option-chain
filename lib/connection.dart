import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class Connection {
  Map<String, String> headersData;

  Options getOptions() {
    return Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: setHeaders(),
    );
  }

  Map<String, dynamic> setHeaders() {
    headersData['Access-Control-Allow-Origin'] = "*";
    headersData['Access-Control-Allow-Credentials'] = "true";
    headersData['Access-Control-Allow-Headers'] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    headersData['Access-Control-Allow-Methods'] = "POST, OPTIONS";
    // if ("Add token here" != null) headersData['token'] = "";
    return headersData;
  }

  Future<Map<String, dynamic>> getDetails(String symbol) async {
    // Map<String, String> headersData = Map<String, String>();

    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));

    await dio.get(
      'https://www.nseindia.com/get-quotes/derivatives?symbol=$symbol',
      // options: getOptions(),
    );

    var cleanResponse = await dio.get(
        'https://www.nseindia.com/api/option-chain-indices?symbol=$symbol');

    return cleanResponse.data;
  }
}

class NetworkConnection {
  static String _baseUrl;
  Map<String, String> headersData;
  var dio = Dio();

  Future<void> callingBaseUrl(String env) async {
    if (_baseUrl == null) env = "URL";
    return _baseUrl = "${env}apis/v1";
  }

  Future<Map<String, dynamic>> getReq(String query) async {
    var getResponse = await dio.get(
      '$_baseUrl$query',
      options: getOptions(),
    );
    return getResponse.data;
  }

  Future<Map<String, dynamic>> postReq(var payload, String api) async {
    var postResponse = await dio.post(
      "$_baseUrl$api",
      options: getOptions(),
      data: payload,
    );
    return postResponse.data;
  }

  Options getOptions() {
    return Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: setHeaders(),
    );
  }

  Map<String, dynamic> setHeaders() {
    headersData['Content-Type'] = "application/json";
    if ("Add token here" != null) headersData['token'] = "";
    return headersData;
  }
}
