

import 'package:adal/Auth/AuthScreens/login.dart';
import 'package:adal/Auth/AuthScreens/register.dart';
import 'package:adal/Auth/LoginAuthProvider.dart';
import 'package:adal/Cases/Case_page.dart';
import 'package:adal/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          '/case': (context) => CasePage(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADAL'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 76, 137, 175),
              ),
              child: Text(
                'ADAL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Case'),
              onTap: () {
                Navigator.pushNamed(context, '/case');
              },
            ),
             ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body:  ListTile(
              title: Text('Dashboard'),
            ),
    );
  }
}
