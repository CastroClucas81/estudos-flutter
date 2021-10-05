import 'package:blocyoutube/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LOGIN_NAME";

  final String? errorMessage;

  const LoginPage({Key? key, this.errorMessage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'sky.lucas@gmail.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    void _authenticate() {
      final signEvent = SignInEvent(_emailController.text,_passwordController.text);
      bloc.add(signEvent);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            widget.errorMessage == null ? const SizedBox() : Text(widget.errorMessage.toString()),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: _authenticate,
                  child: const Text('Acessar Home Page'),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
