import 'dart:collection';

import 'package:chores/core/http_service.dart';
import 'package:chores/models/Chore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({Key? key}) : super(key: key);

  static const routeName = '/GeneratingScreen';

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();


}

class _GeneratingScreenState extends State<GeneratingScreen> {

  late int placeId;
  Future<List<Chore>?>? chores;
  LinkedHashMap<DateTime, List<Chore>>? _groupedEvents;


  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<Chore> chores) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    chores.forEach((chore) {
      DateTime date = chore.when!.add(new Duration(hours: 2));
      if (_groupedEvents![date] == null) {
        _groupedEvents![date] = [];
      }
      _groupedEvents![date]?.add(chore);
    });
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents![date] ?? [];
  }

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
        var data = getGeneratedChores(placeId);
        setState(() {
          chores = data;
        });
      }
    });
    _selectedDay = _focusedDay;
    //_groupedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)) as LinkedHashMap<DateTime, List<Chore>>?;
  }

  Future<List<Chore>?> getGeneratedChores(int placeId) async {
    var data = await HttpService().getGeneratedChores(placeId);
    return data;
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Chores'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body:
        FutureBuilder<List<Chore>?>(
          future: chores,
          builder: (context, snapshot){
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              final chores = snapshot.data;
              _groupEvents(chores!);
              DateTime selectedDate = _selectedDay!;
              final _selectedEvents = _groupedEvents![selectedDate] ?? [];
              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    eventLoader: _getEventsForDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
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
                    //eventLoader: _getEventsForDay,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                        reverse: false,
                        itemBuilder: (context, index){
                            Chore chore = _selectedEvents[index];
                            return ListTile(
                            title: Text(chore.choreName),
                              //subtitle:
                              //Text(DateFormat('EEE, MMM d, ''yy' ).format(chore.when!.toLocal())),
                              trailing: IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.highlight_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    snapshot.data?.remove(chore);
                                  });
                                },),
                          );
                        },
                        //separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
                        itemCount: _selectedEvents.length,),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveListOfChores(snapshot.data);
                    },
                    style:
                    ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                      primary: const Color.fromRGBO(81, 56, 135, 1),
                    ), child: const Text("Create"),
                  ),
                  SizedBox(height: 60,)
                ],
              );
            }else{
              return Text('');
            }
          }
      ),
    );
  }
  void _saveListOfChores(List<Chore>? chores) async{
    //Chore chore
    bool ret = (await HttpService().saveListOfChores(chores, placeId));
    if (ret == true){
      Navigator.pop(context);
    }
  }
}
