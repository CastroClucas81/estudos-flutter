import 'package:bloc/bloc.dart';
import 'package:blocyoutube/bloc/user.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

//receber os eventos
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      //onde vao ficar os eventos
      //e disparando os eventos na aplicacao

      if (event is SignInEvent) {
        try {
          StartLoginState();
          final user = await authenticate(event.email, event.password);
          if (user == null) {
            const ErrorLoginState("Usuário inválido");
          } else {
            SuccessLoginState(user);
          }
        } catch (e) {
          const ErrorLoginState("Ops! Algo deu errado.");
          // ignore: avoid_print
          print(e);
        }
      }
    });
  }

  Future<User> authenticate(String email, String password) {
    return Future.delayed(const Duration(seconds: 3), () {
      if (email == "lucas@gmail.com" && password == "123") {
        return User("Lucas", email);
      }

      return User("DeuRuim", "DeuRuim@gmail.com");
    });
  }
}
