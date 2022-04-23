import 'package:chores/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../login_screen/login_screen.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Frame3Widget - FRAME - VERTICAL

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width-80,
      decoration: const BoxDecoration(
        borderRadius : BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow : [BoxShadow(
            color: Color.fromRGBO(39, 3, 68, 0.10000000149011612),
            offset: Offset(0,6),
            blurRadius: 12
        )],
        color : Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          InkWell(
            onTap: () {myNavigatorKey.currentState?.pushNamed(LoginScreen.routeName);},
            child: Container(
              height: 40,
              width: size.width-160,
              decoration: const BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color : Color.fromRGBO(81, 56, 135, 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,

                children: const <Widget>[
                  Text('Login', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),),

                ],
              ),
            ),
        ), const SizedBox(height : 20),
          InkWell(
            onTap: () {myNavigatorKey.currentState?.pushNamed(RegisterScreen.routeName);},
            child: Container(
            height: 40,
            width: size.width-160,
              decoration: const BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color : Color.fromRGBO(81, 56, 135, 1),
              ),
              //padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,

                children: const <Widget>[
                  Text('Register', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),),

                ],
              ),
            ),
          ), const SizedBox(height : 20),
          Container(
            height: 40,
            width: size.width-160,
            decoration: const BoxDecoration(
              borderRadius : BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color : Color.fromRGBO(81, 56, 135, 1),
            ),
            //padding: EdgeInsets.symmetric(horizontal: 59, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,

              children: const <Widget>[
                Text('Remind password', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Ubuntu',
                    fontSize: 16,
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1
                ),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
