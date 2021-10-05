
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

//entd. cliente pra fazer o get pra gente
final Client client = InterceptedClient.build(interceptors: [
  //instancia interceptador
  LoggingInterceptor(),
]);

const String baseUrl = 'http://172.31.16.1:8080';
