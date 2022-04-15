import 'package:chores/models/User.dart';
import 'package:flutter/material.dart';
import '../components/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/LoginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  User user = User("","","");
  String url = "http://localhost:8080/api/avi/user-profile/login";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          children: <Widget>[
            Container(
                child: TextFormField(
                  controller: TextEditingController(text: user.email),
                  onChanged: (val){
                    user.email = val;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return 'email is Empty';
                    }
                    return null;
                  },
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
      )
    );
  }
  _goToLoginScreen() {
    //myNavigatorKey.currentState?.pushNamed(WelcomeScreen.routeName);
  }
}
