import 'package:chores/core/http_service.dart';
import 'package:chores/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
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
        centerTitle: true,),
      body: Background(
        child: Align(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SvgPicture.asset(
                    'assets/images/login.svg',
                    height: 110,
                ),
                Form(
                    key: _formKey,
                    child: Column(

                      children: <Widget>[
                        Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Login',
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
                                )
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
                            margin: const EdgeInsets.all(40)
                        ),
                        Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Register',
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
                                  )
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
                            margin: const EdgeInsets.all(40)
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            style:
                            ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                            ), child: Text("Submit"),


                          ),
                        ),
                      ],
                    ),
      ),
              ],
            ),
          ),
        )
      )
    );
  }
  void _login() async{
    bool ret = (await HttpService().login(_email,_password));
    if (ret == true){
      myNavigatorKey.currentState?.pushNamed(WelcomeScreen.routeName);
    }
  }
}
