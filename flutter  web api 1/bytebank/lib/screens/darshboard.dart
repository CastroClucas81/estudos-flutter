import 'package:bytebank/screens/contactsList.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/bfb41f89390783.5df2d565dca4d.png'),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  name: 'Transfer',
                  icon: Icons.monetization_on,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                _FeatureItem(
                  name: 'Transaction Feed',
                  icon: Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }
}

void _showTransactionsList(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
