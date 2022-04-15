import 'package:chores/main.dart';
import 'package:chores/screens/components/background.dart';
import 'package:chores/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';


class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          Container(
              child: TextFormField(
                controller: TextEditingController.fromValue(text: user.email),
              ),
              margin: EdgeInsets.all(40)
          ),
          Container(
              child: TextFormField(
              ),
              margin: EdgeInsets.all(40)
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              style:
              ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
              ), child: Text("Submit"),


            ),
          )
        ],
      ),
    );
  }
  _goToLoginScreen() {
    //myNavigatorKey.currentState?.pushNamed(WelcomeScreen.routeName);
  }

  @override
  _LoginState createState() => _LoginState();


}