import 'package:chores/screens/add_user_screen/add_user_screen.dart';
import 'package:chores/screens/create_chore_screen/create_chore_screen.dart';
import 'package:chores/screens/create_place_screen/create_place_screen.dart';
import 'package:chores/screens/generating_screen/generating_screen.dart';
import 'package:chores/screens/login_screen/login_screen.dart';
import 'package:chores/screens/place_screen/place_screen.dart';
import 'package:chores/screens/place_selection_screen/place_selection_screen.dart';
import 'package:chores/screens/register_screen/register_screen.dart';
import 'package:chores/screens/show_users_screen/show_users_screen.dart';
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
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              dayPeriodBorderSide: const BorderSide(color: Color.fromRGBO(81, 56, 135, 1), width: 4),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: Color.fromRGBO(81, 56, 135, 1), width: 4),
              ),
              hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected) ? const Color.fromRGBO(81, 56, 135, 1) : Colors.blueGrey.shade700),
              hourMinuteTextColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.selected) ? Colors.white : Colors.black),
              dialHandColor: Colors.blueGrey.shade700,
              dayPeriodTextColor: const Color.fromRGBO(81, 56, 135, 1)

            ),
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
          CreatePlaceScreen.routeName: (context) =>
              const CreatePlaceScreen(),
          PlaceScreen.routeName: (context) =>
              const PlaceScreen(),
          CreateChoreScreen.routeName: (context) =>
              const CreateChoreScreen(),
          AddUserScreen.routeName: (context) =>
              const AddUserScreen(),
          ShowUsersScreen.routeName: (context) =>
              const ShowUsersScreen(),
          GeneratingScreen.routeName: (context) =>
              const GeneratingScreen(),


        }
    );
  }
}
