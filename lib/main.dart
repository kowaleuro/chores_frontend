import 'package:chores/screens/login_screen/login_screen.dart';
import 'package:chores/screens/place_selection_screen/place_selection_screen.dart';
import 'package:chores/screens/register_screen/register_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chores Manager',
        theme: ThemeData(
            inputDecorationTheme:InputDecorationTheme(
                floatingLabelStyle: const TextStyle(
                    fontSize: 20,
                    color:Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(20)
                )
            ),
        ),
        home: const WelcomeScreen(),
        navigatorKey: myNavigatorKey,
        routes:{
          WelcomeScreen.routeName: (context) =>
          const WelcomeScreen(),
          LoginScreen.routeName: (context) =>
            const LoginScreen(),
          RegisterScreen.routeName: (context) =>
              const RegisterScreen(),
          PlaceSelectionScreen.routeName: (context) =>
          const PlaceSelectionScreen(),
        }
    );
  }
}
