import 'package:bytebank/screens/darshboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
  //Lidando com problemas da comunicação externa
  /*
  save(Contact(0, "Lucao", 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
  */

  //testando save
  //save(Transaction(200.0, Contact(0, "Jorgin", 2349))).then((transaction) => print(transaction));

  //puxando todos da webclient
  //findAll().then((value) => print("new transactions: $value"));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
      home: Dashboard(),
    );
  }
}
