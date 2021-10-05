import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Progress(),
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(
                          transactionId, value ?? 0, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    //quando houver um erro ele vai disparar o show dialog
    Transaction? transaction =
        await _send(transactionCreated, password, context);
    // ignore: unnecessary_null_comparison

    _showSuccessfulMessage(transaction!, context);
  }

  Future<void> _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    // ignore: unnecessary_null_comparison
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Successful transaction");
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction?> _send(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    //quando houver um erro ele vai disparar o show dialog
    final Transaction? transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
      //fazer alguma comparacao se o "e" condiz com o q a gente espera
      //garante q o "e" vai ter uma exception
    }, test: (e) => e is HttpException)
            //lidar com erros genéricos de timeout
            .catchError((e) {
      _showFailureMessage(context,
          message: 'timeout submitting the transaction');
    }, test: (e) => e is TimeoutException)
            //lidando com erros inesperados
            //deve sempre ficar por último
            .catchError((e) {
      _showFailureMessage(context);
      // independente do q acontecer, quando for finalizado (o Future) esse when...
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown error'}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(message);
      },
    );
  }
}
