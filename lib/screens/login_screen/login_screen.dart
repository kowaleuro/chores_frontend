import 'package:chores/core/http_service.dart';
import 'package:chores/screens/place_selection_screen/place_selection_screen.dart';
import 'package:chores/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../../utils/keyboard_hider.dart';
import '../components/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/LoginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  late String _email = '';
  late String _password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: KeyboardHider(
        child: Background(
          child: Align(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //const SizedBox(height: 15),
                  SvgPicture.asset(
                      'assets/images/login.svg',
                      height: 140,
                  ),
                  const SizedBox(height: 20,),
                  Form(
                      key: _formKey,
                      child: Column(

                        children: <Widget>[
                          Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                                controller: TextEditingController(text: _email),
                                onChanged: (val){
                                  _email = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'email is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Register',
                                ),
                                controller: TextEditingController(text: _password),
                                onChanged: (val){
                                  _password = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'email is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            style:
                            ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                              primary: const Color.fromRGBO(81, 56, 135, 1),
                            ), child: const Text("Login"),


                          ),
                        ],
                      ),
        ),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
  void _login() async{
    bool ret = (await HttpService().login(_email,_password));
    if (ret == true){
      myNavigatorKey.currentState?.pushNamed(PlaceSelectionScreen.routeName);
    }
  }
}
