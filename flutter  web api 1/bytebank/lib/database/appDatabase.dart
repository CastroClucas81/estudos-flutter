import 'package:bytebank/database/dao/contactDao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//tudo q for executado vai ser dentro de um future por conta do async
Future<Database> getDatabase() async {
  //await tem a mesma finalidade que o then
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    //aq criamos a tabela
    db.execute(ContactDao.tableSql);
  }, version: 1, onDowngrade: onDatabaseDowngradeDelete);

  /*
  //caminho bd
  return getDatabasesPath().then((dbPath) {
    //criar arquivo q vai representar o bd
    final String path = join(dbPath, 'bytebank.db');

    //abrir o bd
    //criar tabela na hora de abrir o bd
    return openDatabase(
      path,
      onCreate: (db, version) {
        //aq criamos a tabela
        db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'account_number INTEGER)');
      },
      version: 1,
      onDowngrade: onDatabaseDowngradeDelete
    );

  });
  */
}
