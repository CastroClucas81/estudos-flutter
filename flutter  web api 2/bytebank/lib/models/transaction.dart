import 'package:bytebank/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(
    this.id,
    this.value,
    this.contact,
  );

  //pega o json e converte para a transaction
  //quando precisamos passar um outro objeto, utilizamos o fromJson do outro objeto
  Transaction.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        value = json['value'],
        contact = Contact.fromJson(json['contact']);

  //convertendo para json
  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
