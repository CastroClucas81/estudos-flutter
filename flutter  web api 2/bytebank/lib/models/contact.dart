class Contact {
  late final int id;
  late final String name;
  late final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'accountNumber': accountNumber,
  };
}
