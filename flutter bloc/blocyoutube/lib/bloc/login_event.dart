part of 'login_bloc.dart';

//onde vao ficar meus eventos
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SignInEvent extends LoginEvent {
  //ele nao vai ficar mudando
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);

  //equatable
  @override
  List<Object?> get props => [email, password];
}
