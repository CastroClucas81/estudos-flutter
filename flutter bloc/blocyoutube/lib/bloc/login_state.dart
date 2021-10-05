part of 'login_bloc.dart';

//vao ser criados aquis
abstract class LoginState extends Equatable {
  const LoginState();
}


class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

//só precisamos saber como ele está para exibir o loading
class StartLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends LoginState {
  final User user;

  const SuccessLoginState(this.user);

  @override
  List<Object?> get props => [user];
}

class ErrorLoginState extends LoginState {
  final String message;

  const ErrorLoginState(this.message);

  @override
  List<Object?> get props => [message];
}
