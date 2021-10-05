import 'package:bytebank/database/appDatabase.dart';
import 'package:bytebank/database/dao/contactDao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/ContactForm.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.green[900],
      ),
      body: FutureBuilder<List<Contact>>(
        //deficindo um vetor vazio inicial enquanto o future n termina
        initialData: [],
        //chamando o método q será passado para o future
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              //o future ainda n foi executado
              //colocar um botão para executar o future
              break;
            case ConnectionState.waiting:
              //verificando que o nosso future ainda esta carregando
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Loading...')],
                ),
              );
            case ConnectionState.active:
              //tem dado disponível mas o future n foi finalizado
              //bom pra usar em download. Ex.: carregou 20% ele já traz
              break;
            case ConnectionState.done:
              //quando ta tudo certo
              //enquando o delayed n acabar os dados não serão exibidos
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ContactItem(contact);
                },
                itemCount: contacts.length,
              );
          }

          //devolvendo um valor padrão
          return Text("Unknown error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
            //solucao improvisada para recarregar os dados
          ).then((value) => setState(() {}));
          /*
            .then(
            (newContact) => debugPrint(newContact.toString()),
            )
          */
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  late final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(),
        ),
      ),
    );
  }
}
