
import 'dart:collection';

import 'package:chores/models/User.dart';
import 'package:chores/models/status.dart';
import 'package:chores/screens/add_user_screen/add_user_screen.dart';
import 'package:chores/screens/create_chore_screen/create_chore_screen.dart';
import 'package:chores/screens/generating_screen/generating_screen.dart';
import 'package:chores/screens/show_users_screen/show_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../core/http_service.dart';
import '../../main.dart';
import '../../models/Chore.dart';
import '../../models/Place.dart';


class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/PlaceScreen';

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();


}


class _PlaceScreenState extends State<PlaceScreen> {

  LinkedHashMap<DateTime, List<Chore>>? _groupedEvents;
  Future<Place?>? place;
  Future<List<User>?>? users;
  late int placeId;

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
        var data = getPlace(placeId);
        var usersData = getUsers(placeId);
        setState(() {
          place = data;
          users =usersData;
        });
      }
    });
    _selectedDay = _focusedDay;
    //_groupedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)) as LinkedHashMap<DateTime, List<Chore>>?;
  }



  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<Chore> chores) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    chores.forEach((chore) {
      DateTime date = chore.when!;
      if (_groupedEvents![date] == null) {
        _groupedEvents![date] = [];
      }
      _groupedEvents![date]?.add(chore);
    });
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents![date] ?? [];
  }

  Future<Place?> getPlace(int placeId) async {
      var data = await HttpService().getPlaceById(placeId);
      return data;
  }

  Future<List<User>?> getUsers(int placeId) async {
    var data = await HttpService().getUsersOfPlace(placeId);
    return data;
  }


  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          title: FutureBuilder<Place?>(
              future: place,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data!.placeName + ' #' + snapshot.data!.placeId.toString() );
                }else{
                  return Text('');
                }
              }
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Place?>(
          future: place,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              final chores = snapshot.data?.chores;
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Chore chore = _selectedEvents[index];
                      if(chore.status==Status.OPEN) {
                        // return ListTile(
                        //   title: Text(chore.choreName),
                        //   // subtitle: Text(
                        //   //     DateFormat("EEEE, dd MMMM, hh:mm aaa").format(
                        //   //         chore.when!)),
                        //   subtitle: Text(chore.userCloser?.nickname ?? ""),
                        //   trailing: IconButton(
                        //     color: Colors.red,
                        //     icon: const Icon(Icons.highlight_off_outlined),
                        //     onPressed: () {
                        //       chore.status = Status.FINISHED;
                        //       updateStatus(chore);
                        //       setState(() {
                        //         place = getPlace(placeId);
                        //       });
                        //       },),
                        //   //leading: Icon(Icons.email),
                        // );
                        return  ExpansionTile(
                          title: Text(chore.choreName),
                          subtitle: Text(chore.userCloser?.nickname ?? ""),
                          controlAffinity: ListTileControlAffinity.leading,
                            trailing: IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.highlight_off_outlined),
                              onPressed: () {
                                chore.status = Status.FINISHED;
                                updateStatus(chore);
                                },),
                          children: <Widget>[
                            FutureBuilder(
                              future: users,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotUser) {
                                if (snapshotUser.hasData && snapshotUser.connectionState == ConnectionState.done) {
                                  return ListView.builder(
                                    reverse: false,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) =>
                                        Center(
                                            child: ListTile(
                                              title:
                                                Text(
                                                  snapshotUser.data?[index2].nickname ?? "got null",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(81, 56, 135, 1)
                                                  )
                                                  ,
                                                ),
                                                trailing: IconButton(
                                                  color: (snapshotUser.data?[index2].email == chore.userCloser?.email)
                                                      ? const Color.fromRGBO(81, 56, 135, 1)
                                                      : Colors.black26,
                                                  icon:  const Icon(Icons.person),
                                                  onPressed: () {
                                                    if((snapshotUser.data?[index2].email != chore.userCloser?.email)) {
                                                      subscribeUser(
                                                          chore.choreId,
                                                          snapshotUser
                                                              .data?[index2]
                                                              .email);
                                                    }
                                                    // setState(() {
                                                    //   place = getPlace(placeId);
                                                    // });
                                                  }
                                                  )
                                            )
                                        ),
                                      itemCount: snapshotUser.data!.length);
                                }
                                else {
                                  return const Text('');
                                }
                              },
                            ),
                          ],
                        );
                      }else{
                        return ListTile(
                          title: Text(chore.choreName),
                          subtitle: Text(chore.userCloser?.nickname ?? ""),
                          trailing: const Icon(Icons.check_circle_outline_outlined,
                            color: Colors.green),
                        );
                      }
                      }
                  )
                ],

              );
            }else return Text('');
          }
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.logout_rounded),
            label: 'Logout',
            //onTap: () {myNavigatorKey.currentState?.pushNamed(CreatePlaceScreen.routeName);},
          ),
          SpeedDialChild(
            child: const Icon(Icons.attribution_rounded),
            label: 'Show Users',
            onTap: () {
              myNavigatorKey.currentState?.pushNamed(ShowUsersScreen.routeName,
                  arguments: {'placeId': placeId}).then((value) {
                setState(() {
                  place = getPlace(placeId);
                });
              })
              ;},
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add users',
            onTap: () {
              myNavigatorKey.currentState?.pushNamed(AddUserScreen.routeName,
                  arguments: {'placeId': placeId}).then((value) {
                setState(() {
                  place = getPlace(placeId);
                });
              })
              ;},
          ),
          SpeedDialChild(
            child: const Icon(Icons.settings_suggest_outlined),
            label: 'Generate',
            onTap: () {
              myNavigatorKey.currentState?.pushNamed(GeneratingScreen.routeName,
                  arguments: {'placeId': placeId}).then((value) {
                setState(() {
                  place = getPlace(placeId);
                });
              })
              ;},
          ),
          SpeedDialChild(
            child: const Icon(Icons.create_outlined),
            label: 'Create chore',
            onTap: () {
              myNavigatorKey.currentState?.pushNamed(CreateChoreScreen.routeName,
                arguments: {'placeId': placeId}).then((value) {
              setState(() {
                place = getPlace(placeId);
              });
                })
              ;},
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(121, 121, 121, 1),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {Navigator.of(context).pop();},
            ),
            const Spacer(),
          ],
        ),
        shape: const CircularNotchedRectangle(),
      ),
    );
  }

  void updateStatus(Chore chore) async{
    //Chore chore
   await HttpService().updateChoreStatus(chore);
   setState(() {
     place = getPlace(placeId);
   });
  }

  void subscribeUser(int? choreId, String email) async {
    if (choreId != null) {
      await HttpService().subscribeUserToChore(choreId, email);
      setState(() {
        place = getPlace(placeId);
      });
    }
  }
}

