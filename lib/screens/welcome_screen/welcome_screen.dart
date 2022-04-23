import 'package:chores/screens/welcome_screen/main_image.dart';
import 'package:chores/screens/welcome_screen/main_menu.dart';
import 'package:flutter/material.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const routeName = '/WelcomeScreen';

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Chores Manager"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: Align(
        child: Column(
          children: const [
            SizedBox(height: 25),
            MainImage(),
            SizedBox(height: 50),
            MainMenu()
          ],
        ),
      ),
    );
  }
}