import 'package:http_interceptor/http_interceptor.dart';

/*
    interceptador do http
    ele fica atento a qualquer requisição
    se enviarmos ou recebermos ele vai saber
  */
class LoggingInterceptor implements InterceptorContract {
  //RequestData: dados da requisição
  //todo o tipo de requisião vai chamar esse método
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('url: ${data.baseUrl}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  //RequestData: dados da resposta
  //toda resposta vai chamar esse método
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}
