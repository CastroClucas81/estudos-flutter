import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

//entd. cliente pra fazer o get pra gente
final Client client = InterceptedClient.build(
  interceptors: [
    //instancia interceptador
    LoggingInterceptor(),
  ],
  requestTimeout: Duration(seconds: 5),
);

const String baseUrl = 'http://172.21.0.1:8080/transactions';
