import 'dart:convert';

import 'package:bytebank/http/webcliente.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

//é como se fosse o DAO para API's
class TransactionWebClient {
  //api trazer todas as transacoes
  Future<List<Transaction>> findAll() async {
    //buscar dados
    //local host representa a maquina que está executando
    //por isso coloquei o ip da rede (ipv 4)
    final Response response = await client.get(Uri.parse(baseUrl));

    //convertendo json pra list
    final List<dynamic> decodedJson = jsonDecode(response.body);

    //pega cada elemento do decoJson e transforma numa lista nova
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  //salvar na api a transacao
  Future<Transaction?> save(Transaction transaction, String password) async {
    //converter o transactionMap para string json
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-type': 'application/json',
        "password": password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      //convertendo a resposta para map
      //convertendo o json(response) para o transaction
      return Transaction.fromJson(jsonDecode(response.body));
    }

    //identificando resp para lançar exception
    throw HttpException(_getMessage(response.statusCode));
  }

  //identificar se o statusCode existe ou nao
  String? _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return "Unknown error";
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction.',
    401: 'authentication failed.',
    409: 'transaction always exists.'
  };
}

//criando exception para http
class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
