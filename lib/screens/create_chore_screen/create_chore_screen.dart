import 'package:chores/models/Chore.dart';
import 'package:chores/models/status.dart';
import 'package:chores/screens/place_screen/place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/http_service.dart';
import '../../main.dart';
import '../../utils/keyboard_hider.dart';
import '../components/background.dart';
import '../place_selection_screen/place_selection_screen.dart';

class CreateChoreScreen extends StatefulWidget {
  const CreateChoreScreen({Key? key}) : super(key: key);

  static const routeName = '/CreateChoreScreen';

  @override
  State<CreateChoreScreen> createState() => _CreateChoreScreenState();
}

class _CreateChoreScreenState extends State<CreateChoreScreen> {

  final _createChoreKey = GlobalKey<FormState>();
  late String _choreName = '';

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay selectedTime = TimeOfDay(hour: 24, minute: 0);
  //late String _placeImageLink = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Chore"),
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
                    Form(
                      key: _createChoreKey,
                      child: Column(

                        children: <Widget>[
                          SizedBox(height: 20,),
                          Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Chore Name',
                                ),
                                controller: TextEditingController(text: _choreName),
                                onChanged: (val){
                                  _choreName = val;
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Chore Name is Empty';
                                  }
                                  return null;
                                },
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 0)
                          ),
                          const SizedBox(height: 20,),
                          TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: DateTime.now(),
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay; // update `_focusedDay` here as well
                              });
                            },
                            calendarFormat: _calendarFormat,
                            onFormatChanged: (format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () {
                              if (_createChoreKey.currentState!.validate()) {
                                final arguments =  (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
                                final int placeId = arguments['placeId'];
                                print(placeId);
                                _createChore(placeId);
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
  void _createChore(int placeId) async{
    //Chore chore
    if(_selectedDay != null) {
      DateTime dateTime = DateTime(
          _selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
      Chore chore = Chore(null, _choreName, Status.OPEN, dateTime, null);
      bool ret = (await HttpService().createChore(chore, placeId));
      if (ret == true) {
        Navigator.pop(context);
      }
    }else{
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remember to select the day!'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                SvgPicture.asset(
                  'assets/images/createPlace.svg',
                  height: 140,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
