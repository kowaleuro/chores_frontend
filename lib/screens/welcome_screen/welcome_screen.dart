import 'package:chores/screens/welcome_screen/welcome_screen_body.dart';
import 'package:flutter/material.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const routeName = '/WelcomeScreen';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: WelcomeScreenBody(),
    );
  }
}