import 'package:flutter/material.dart';
import 'package:adal/Auth/AuthScreens/register.dart';
import 'package:adal/intro_page.dart';
import 'package:provider/provider.dart';
import './Auth/AuthScreens/login.dart';
import './Auth/LoginAuthProvider.dart';
import 'main_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ADAL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/intro',
        routes: {
          '/intro': (context) => IntroPage(),
          '/register': (context) => Register(),
          '/login': (context) => Login(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
