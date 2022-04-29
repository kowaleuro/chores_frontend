import 'package:chores/core/http_service.dart';
import 'package:chores/utils/keyboard_hider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../components/background.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formRegisterKey = GlobalKey<FormState>();
  late String _email = '';
  late String _nickname = '';
  late String _password = '';
  late String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Registration"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: KeyboardHider(
        child: Background(
          child: Align(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formRegisterKey,
                    child: Column(
                        children: <Widget>[
                          //const SizedBox(height: 40,),
                          Container(
                            child: TextFormField(
                              scrollPadding: EdgeInsets.only(bottom:40),
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
                                  labelText: 'Nickname',
                                ),
                                controller: TextEditingController(text: _nickname),
                                onChanged: (val){
                                  _nickname = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'nickname is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          Container(
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                ),
                                controller: TextEditingController(text: _password),
                                onChanged: (val){
                                  _password = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'password is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          Container(

                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                ),
                                controller: TextEditingController(text: _confirmPassword),
                                onChanged: (val){
                                  _confirmPassword = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'confirmPassword is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_formRegisterKey.currentState!.validate()) {
                                _register();
                              }
                            },
                            style:
                            ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                              primary: const Color.fromRGBO(81, 56, 135, 1),
                            ), child: const Text("Register"),


                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),

    );
  }

  void _register() async{
    bool ret = await HttpService().register(_email,_password,_nickname);
    if(ret == true){
      myNavigatorKey.currentState?.pushNamed(LoginScreen.routeName);
    }
  }
}
