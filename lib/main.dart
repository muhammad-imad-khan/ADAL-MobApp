import 'package:Adal/Auth/AuthScreens/login.dart';
import 'package:Adal/Auth/LoginAuthProvider.dart';
import 'package:Adal/BarChart/BarChartMonthly.dart';
import 'package:Adal/BarChart/BarChartWeekly.dart';
import 'package:Adal/BarChart/BarChartYearly.dart';
import 'package:Adal/Cases/Case_page.dart';
import 'package:Adal/Cases/ClientCases/client_cases.dart';
import 'package:Adal/Cases/LawyerCases/lawyer_cases.dart';
import 'package:Adal/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = await getInitialRoute();
  runApp(MainApp(initialRoute: initialRoute));
}

Future<String> getInitialRoute() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('auth_role');

  switch (role) {
    case 'Client':
      return '/clientCase';
    case 'Lawyer':
      return '/lawyerCase';
    case 'Admin':
      return '/case';
    default:
      return '/login';
  }
}

class MainApp extends StatelessWidget {
  final String initialRoute;

  MainApp({required this.initialRoute});

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
        initialRoute: initialRoute,
        routes: {
          '/intro': (context) => IntroPage(),
          '/login': (context) => Login(),
          '/main': (context) => MainPage(),
          '/clientCase': (context) => ClientCasePage(),
          '/lawyerCase': (context) => LawyerCasePage(),
          '/case': (context) => CasePage(),
          '/weekly': (context) => BarChartWeekly(),
          '/monthly': (context) => BarChartMonthly(),
          '/yearly': (context) => BarChartYearly(),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            return FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String? role = snapshot.data?.getString('auth_role');
                  if (role == 'Client' &&
                      !clientRoutes.contains(settings.name)) {
                    return UnauthorizedPage();
                  } else if (role == 'Lawyer' &&
                      !lawyerRoutes.contains(settings.name)) {
                    return UnauthorizedPage();
                  } else if (role == 'Admin' &&
                      !adminRoutes.contains(settings.name)) {
                    return UnauthorizedPage();
                  }
                  return _buildPage(settings.name!);
                }
                return CircularProgressIndicator();
              },
            );
          });
        },
      ),
    );
  }

  Widget _buildPage(String routeName) {
    switch (routeName) {
      case '/clientCase':
        return ClientCasePage();
      case '/lawyerCase':
        return LawyerCasePage();
      case '/case':
        return CasePage();
      case '/weekly':
        return BarChartWeekly();
      case '/monthly':
        return BarChartMonthly();
      case '/yearly':
        return BarChartYearly();
      default:
        return Login();
    }
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? role = snapshot.data?.getString('auth_role');
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
                      color: Color.fromARGB(255, 76, 137, 175),
                    ),
                    child: Text(
                      'Adal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  if (role == 'Admin' || role == 'Client')
                    ListTile(
                      title: Text('Client Cases'),
                      onTap: () {
                        Navigator.pushNamed(context, '/clientCase');
                      },
                    ),
                  if (role == 'Admin' || role == 'Lawyer')
                    ListTile(
                      title: Text('Lawyer Cases'),
                      onTap: () {
                        Navigator.pushNamed(context, '/lawyerCase');
                      },
                    ),
                  if (role == 'Admin')
                    ListTile(
                      title: Text('Cases'),
                      onTap: () {
                        Navigator.pushNamed(context, '/case');
                      },
                    ),
                  if (role == 'Admin')
                    ListTile(
                      title: Text('Weekly Report'),
                      onTap: () {
                        Navigator.pushNamed(context, '/weekly');
                      },
                    ),
                  if (role == 'Admin')
                    ListTile(
                      title: Text('Monthly Report'),
                      onTap: () {
                        Navigator.pushNamed(context, '/monthly');
                      },
                    ),
                  if (role == 'Admin')
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome to the ADAL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24), // You can adjust the font size
                    ),
                    SizedBox(height: 20), // Add some spacing
                    BarChartYearly(),
                  ],
                ),
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class UnauthorizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unauthorized'),
      ),
      body: Center(
        child: Text('You are not authorized to access this page.'),
      ),
    );
  }
}

// Define role-specific routes
const List<String> clientRoutes = [
  '/clientCase',
  '/login',
];

const List<String> lawyerRoutes = [
  '/lawyerCase',
  '/login',
];

const List<String> adminRoutes = [
  '/case',
  '/clientCase',
  '/lawyerCase',
  '/weekly',
  '/monthly',
  '/yearly',
  '/login',
];
