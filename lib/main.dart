import 'package:Adal/Auth/AuthScreens/login.dart';
import 'package:Adal/Auth/LoginAuthProvider.dart';
import 'package:Adal/BarChart/BarChartMonthly.dart';
import 'package:Adal/BarChart/BarChartWeekly.dart';
import 'package:Adal/BarChart/BarChartYearly.dart';
import 'package:Adal/Cases/Case_page.dart';
import 'package:Adal/intro_page.dart';
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
        title: 'Adal',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/intro',
        routes: {
          '/intro': (context) => IntroPage(),
          '/login': (context) => Login(),
          '/main': (context) => MainPage(),
          '/case': (context) => CasePage(),
          '/weekly': (context) => BarChartWeekly(),
          '/monthly': (context) => BarChartMonthly(),
          '/yearly': (context) => BarChartYearly(),
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
        title: Text('Adal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Adal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Cases'),
              onTap: () {
                Navigator.pushNamed(context, '/case');
              },
            ),
            ListTile(
              title: Text('Client'),
              onTap: () {
                Navigator.pushNamed(context, '/client');
              },
            ),
             ListTile(
              title: Text('Weekly Report'),
              onTap: () {
                Navigator.pushNamed(context, '/weekly');
              },
            ),
            ListTile(
              title: Text('Monthly Report'),
              onTap: () {
                Navigator.pushNamed(context, '/monthly');
              },
            ),
            ListTile(
              title: Text('Yearly Report'),
              onTap: () {
                Navigator.pushNamed(context, '/yearly');
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Dashboard"),
              SizedBox(height: 20), // Add some spacing
              BarChartYearly(),
            ],
          ),
        ),
      ),
    );
  }
}
