import 'package:chores/main.dart';
import 'package:chores/screens/components/background.dart';
import 'package:chores/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';


class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          Container(
              child: ElevatedButton(
                  onPressed: (){
                    myNavigatorKey.currentState?.pushNamed(LoginScreen.routeName);
                  },
                  style:
                    ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                ), child: Text("Login"),


              ),
              margin: EdgeInsets.all(40)
          ),
          Container(
              child: ElevatedButton(
                onPressed: () {},
                style:
                ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                ), child: Text("Register"),


              ),
          )
        ],
      ),
    );
  }
  _goToLoginScreen() {
    //myNavigatorKey.currentState?.pushNamed(WelcomeScreen.routeName);
  }
}
