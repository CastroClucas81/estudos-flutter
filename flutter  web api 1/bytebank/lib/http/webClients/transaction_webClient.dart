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
    final Response response = await client.get(Uri.parse(baseUrl)).timeout(
          Duration(seconds: 4),
        );

    //convertendo json pra list
    final List<dynamic> decodedJson = jsonDecode(response.body);

    //pega cada elemento do decoJson e transforma numa lista nova
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  //salvar na api a transacao
  Future<Transaction> save(Transaction transaction) async {
    //converter o transactionMap para string json
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-type': 'application/json',
        "password": '1000',
      },
      body: transactionJson,
    );

    //convertendo a resposta para map
    //convertendo o json(response) para o transaction
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
