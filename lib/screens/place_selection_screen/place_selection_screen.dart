import 'package:flutter/material.dart';

import '../../core/http_service.dart';
import '../../main.dart';
import '../../models/Place.dart';

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
    places = HttpService().getUserPlaces();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int count = -1;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
        ),
        body: Center(
          child: FutureBuilder<List<Place>?>(
            future: places,
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length*2+1,
                    itemBuilder: (context, index) {
                      if (index % 2 == 1) {
                        count ++;
                        return Center(
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
                                    snapshot.data?[count].placeName ?? "got null",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ),
                            onTap: () {},
                          ),
                        );
                      }else{
                        return SizedBox(height: 40,);
                      }
                    }
                );
              }else{
                return Text('error');
              }
            }
          ),
        ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          onPressed: () { },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          elevation: 2.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(icon: Icon(Icons.email), onPressed: () {},),
          ],
        ),
        // shape: const AutomaticNotchedShape(
        //     RoundedRectangleBorder(),
        //     StadiumBorder(side: BorderSide())
        // ),
        ),
    );
  }
}
