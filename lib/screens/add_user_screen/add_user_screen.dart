import 'package:flutter/material.dart';

import '../../core/http_service.dart';
import '../../main.dart';
import '../../utils/keyboard_hider.dart';
import '../components/background.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  static const routeName = '/AddUserScreen';

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _AddUserKey = GlobalKey<FormState>();
  late String _userName = '';

  int? placeId;
  //late String _placeImageLink = '';

  @override
  void initState(){
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) {
      if (ModalRoute
          .of(context)
          ?.settings
          .arguments != null) {
        final arguments = (ModalRoute
            .of(context)
            ?.settings
            .arguments ?? <String, dynamic>{}) as Map;
        placeId = arguments['placeId'];
      }
    });
    //_groupedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)) as LinkedHashMap<DateTime, List<Chore>>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add user to your place"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: KeyboardHider(
        child: Background(
            child: Align(
              child: SingleChildScrollView(
                child: Form(
                      key: _AddUserKey,
                      child: Column(

                        children: <Widget>[
                          Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'User Email',
                                ),
                                controller: TextEditingController(text: _userName),
                                onChanged: (val){
                                  _userName = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'User Email is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_AddUserKey.currentState!.validate()) {
                                addUser();
                              }
                            },
                            style:
                            ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                              primary: const Color.fromRGBO(81, 56, 135, 1),
                            ), child: const Text("Add user to place"),


                          ),
                        ],
                      ),
                    ),
                ),
              ),
            )
        ),
    );
  }

  void addUser() async {
    bool ret = (await HttpService().joinPlace(_userName,placeId!));
    if (ret == true){
      Navigator.pop(context);
    }
  }
}
