import 'package:chores/screens/create_place_screen/create_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../core/http_service.dart';
import '../../main.dart';
import '../../models/Place.dart';
import '../place_screen/place_screen.dart';
import '../welcome_screen/welcome_screen.dart';

class PlaceSelectionScreen extends StatefulWidget {
  const PlaceSelectionScreen({Key? key}) : super(key: key);

  static const routeName = '/PlaceSelectionScreen';

  @override
  State<PlaceSelectionScreen> createState() => _PlaceSelectionScreenState();
}

class _PlaceSelectionScreenState extends State<PlaceSelectionScreen> {

  late Future<List<Place>?> places;

  @override
  void initState(){
    super.initState();
    //places = HttpService().getUserPlaces();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
          automaticallyImplyLeading: false
        ),
        body: Center(
          child: FutureBuilder<List<Place>?>(
            future: places = HttpService().getUserPlaces(),
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                    reverse: false,
                    itemBuilder: (context, index) =>
                        Center(
                          child: InkWell(
                            child: Container(
                                height: 140,
                                width: size.width - 150,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: Color.fromRGBO(81, 56, 135, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data?[index].placeName ?? "got null",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ),
                            onTap: () {
                              myNavigatorKey.currentState?.pushNamed(PlaceScreen.routeName,
                              arguments: {'placeId':snapshot.data?[index].placeId}
                            );},
                          ),
                        )
                    , separatorBuilder: (contex, index) => const SizedBox(height: 40,)
                    , itemCount: snapshot.data!.length);
              }else{
                return const Text('');
              }
            }
          ),
        ),
      // floatingActionButton: FloatingActionButton(
      //       //     backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      //       //     shape: const RoundedRectangleBorder(
      //       //         borderRadius: BorderRadius.all(Radius.circular(14)),
      //       //     ),
      //       //     onPressed: () { },
      //       //     tooltip: 'Increment',
      //       //     child: const Icon(Icons.add),
      //       //     elevation: 2.0),

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.logout_rounded),
            label: 'Logout',
            onTap: () {
              storage.delete(key: 'jwt');
              myNavigatorKey.currentState?.pushReplacementNamed(WelcomeScreen.routeName);},
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_circle),
            label: 'Create',
            onTap: () {myNavigatorKey.currentState?.pushNamed(CreatePlaceScreen.routeName);},
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
                  Icons.refresh,
                  color: Colors.white,
              ),
              onPressed: () {setState(() {});},
            ),
            const Spacer(),
          ],
        ),
        shape: const CircularNotchedRectangle(),
        ),
    );
  }
}
