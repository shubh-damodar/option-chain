import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class Connection {
  Future<Map<String, dynamic>> getDetails(String symbol) async {
    // Map<String, String> headersData = Map<String, String>();
    // headersData['Content-Type'] = "application/json";
    // headersData['User-Agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)";
    // headersData['accept-language'] = "en,gu;q=0.9,hi;q=0.8";
    // headersData['accept-encoding'] = "gzip, deflate, br";

    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));

    await dio
        .get('https://www.nseindia.com/get-quotes/derivatives?symbol=$symbol');

    var cleanResponse = await dio.get(
        'https://www.nseindia.com/api/option-chain-indices?symbol=$symbol');

    return cleanResponse.data;
  }
}
