import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:rentabook/authentication/authentication_bloc.dart';
import 'package:rentabook/authentication/user_repo.dart';
import 'package:rentabook/models/book.dart';
import 'package:rentabook/models/user.dart';
import 'package:rentabook/page/book_menu_page.dart';
import 'package:rentabook/bloc/bloc_delegate.dart';
import 'package:rentabook/page/login_page.dart';
import 'package:rentabook/page/splash_page.dart';

void main() async {
  // Widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Setup
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(UserAdapter());

  // Bloc Setup
  BlocSupervisor.delegate = MyBlocDelegate();
  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatefulWidget {
  final UserRepository userRepository;

  const MyApp({Key key, this.userRepository}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState(userRepository: userRepository);
}

class _MyAppState extends State<MyApp> {
  final UserRepository userRepository;

  _MyAppState({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      if (state is AuthenticationUninitialized) {
        return SplashPage();
      }
      if (state is AuthenticationAuthenticated) {
        return FutureBuilder(
          future: Hive.openBox('books'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return BookMenuPage();
            } else
              return Scaffold();
          },
        );
      }
      if (state is AuthenticationUnauthenticated) {
        return LoginPage(userRepository: userRepository);
      }
      if (state is AuthenticationLoading) {
        return LoadingIndicator();
      }
    }));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
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
