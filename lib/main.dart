import 'package:chores/screens/login_screen/login_screen.dart';
import 'package:chores/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: WelcomeScreen(),
        navigatorKey: myNavigatorKey,
        routes:{
          WelcomeScreen.routeName: (context) =>
          const WelcomeScreen(),
          LoginScreen.routeName: (context) =>
            const LoginScreen(),
        }
    );
  }
}
