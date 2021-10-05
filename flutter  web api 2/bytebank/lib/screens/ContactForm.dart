import 'package:bytebank/database/dao/contactDao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Full name",
              ),
              controller: _nameController,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Account number",
              ),
              controller: _accountNumberController,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final String name = _nameController.text;
                  final int? accountNumber =
                      int.tryParse(_accountNumberController.text);

                  final Contact newContact = Contact(0, name, accountNumber!);

                  _dao.save(newContact)
                      .then((id) => Navigator.pop(context, newContact));
                      /*
                        Navigator.pop(context, newContact))
                      */
                },
                child: Text("Create"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
