class Contact {
  late final int id;
  late final String name;
  late final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber
  );

  @override
  String toString() {

    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}