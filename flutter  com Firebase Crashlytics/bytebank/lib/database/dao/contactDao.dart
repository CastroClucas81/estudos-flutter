import 'package:bytebank/database/appDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bytebank/models/contact.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  //o insert retorna um future com o id
//salvar no banco
  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_tableName, contactMap);
    /*
  //criando o database
  return getDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert('contacts', contactMap);
  });
  */
  }

  Map<String, dynamic> _toMap(Contact contact) {
     final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    await db.query(_tableName);
    //pegando o resultado
    final List<Map<String, dynamic>> result = await db.query('contacts');

    //criando uma nova lista
    List<Contact> contacts = toList(result);

    //retornando lista de contatos
    return contacts;
    /*
  return getDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = [];

      for (Map<String, dynamic> map in maps) {
        //devolvando para o model
        final Contact contact =
            Contact(map['id'], map['name'], map['account_number']);
        contacts.add(contact);
      }

      return contacts;
    });
  });
  */
  }

  List<Contact> toList(List<Map<String, dynamic>> result) {
     //criando uma nova lista
    final List<Contact> contacts = [];

    //operando em cada linha encontrada no result
    for (Map<String, dynamic> row in result) {
      //criando o model contato
      final Contact contact =
          Contact(row[_id], row[_name], row[_accountNumber]);
      //importando pra lista
      contacts.add(contact);
    }
    return contacts;
  }
}
