import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rentabook/authentication/user_repo.dart';
import 'package:rentabook/authentication/authentication_bloc.dart';
import 'package:rentabook/login/login_bloc.dart';
import 'package:rentabook/widget/subheader.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          subheader(context, 'Login Now'),
          BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                userRepository: userRepository
              );
            },
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text
        )
      );
    }

    return BlocListener<LoginBloc, LoginState> (
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            )
          );
        }
      },

      child: BlocBuilder<LoginBloc, LoginState> (
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Passsword'),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                  ),
                  Container(
                    child: state is LoginLoading ? CircularProgressIndicator() : null,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}