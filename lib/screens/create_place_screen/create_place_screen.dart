import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/http_service.dart';
import '../../main.dart';
import '../../utils/keyboard_hider.dart';
import '../components/background.dart';
import '../place_selection_screen/place_selection_screen.dart';

class CreatePlaceScreen extends StatefulWidget {
  const CreatePlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/CreatePlaceScreen';

  @override
  State<CreatePlaceScreen> createState() => _CreatePlaceScreenState();
}

class _CreatePlaceScreenState extends State<CreatePlaceScreen> {
  final _createPlaceKey = GlobalKey<FormState>();
  late String _placeName = '';
  //late String _placeImageLink = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Create Place"),
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
                      'assets/images/createPlace.svg',
                      height: 140,
                  ),
                  const SizedBox(height: 20,),
                  Form(
                      key: _createPlaceKey,
                      child: Column(

                        children: <Widget>[
                          Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Place Name',
                                ),
                                controller: TextEditingController(text: _placeName),
                                onChanged: (val){
                                  _placeName = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'place Name is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_createPlaceKey.currentState!.validate()) {
                                _createPlace();
                              }
                            },
                            style:
                            ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                              primary: const Color.fromRGBO(81, 56, 135, 1),
                            ), child: const Text("Create"),


                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  void _createPlace() async{
    bool ret = (await HttpService().createPlace(_placeName));
    if (ret == true){
      myNavigatorKey.currentState?.pushNamed(PlaceSelectionScreen.routeName);
    }
  }
}
