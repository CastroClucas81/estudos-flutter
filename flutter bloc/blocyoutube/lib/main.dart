import 'package:blocyoutube/bloc/login_bloc.dart';
import 'package:blocyoutube/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          )
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          //instancia criada acima
          builder: (context, state) {
            if (state is StartLoginState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ErrorLoginState) {
              return LoginPage(errorMessage: state.message);
            }

            if (state is SuccessLoginState) {
              return const MyHomePage(title: "Flutter Demo Home Page");
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = "HOME_PAGE";

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
