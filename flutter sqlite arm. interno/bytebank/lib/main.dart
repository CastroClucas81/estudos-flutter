import 'package:bytebank/screens/darshboard.dart';
import 'package:flutter/material.dart';

//parei na aula "Finalizando o fluxo do App com o banco de dados"

void main() {
  runApp(BytebankApp());
  /*
  save(Contact(0, "Lucao", 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
  */

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
