import 'dart:async';

import 'package:bytebank/screens/darshboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
//biblioteca para debug do crashlytics
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //inicializar o firebase antes
  await Firebase.initializeApp();

  //forcar modo debug do crashlytics
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    //identificar qual usuário passou pelo erro
    FirebaseCrashlytics.instance.setUserIdentifier("lucas cardoso");

    //ao invés e disparar os erros no aplicativo, ele vai jogar no crashlytics
    //obs.: apenas erros de aplicativo
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  //caso o flutter n perceba o erro, o runZoneGuard vai notar
  runZonedGuarded<Future<void>>(
    () async {
      runApp(BytebankApp());
      //Lidando com problemas da comunicação externa
    },
    FirebaseCrashlytics.instance.recordError,
  );

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
