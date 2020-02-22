part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    this.username,
    this.password
  });

  @override
  // TODO: implement props
  List<Object> get props => [username, password];

  @override
  String toString() => 
    'LoggingButtonPressed { username: $username, password: $password } '; 
}