import 'package:flutter/material.dart';

import '../../core/http_service.dart';
import '../../models/Place.dart';


class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/PlaceScreen';

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();


}


class _PlaceScreenState extends State<PlaceScreen> {

  late Future<Place?> place;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final arguments =  (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final int placeId = arguments['placeId'];

    return Scaffold(
      appBar: AppBar(
          title: FutureBuilder<Place?>(
              future: place = HttpService().getPlaceById(placeId),
              builder: (context, snapshot){
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data!.placeName);
                }else{
                  return Text('');
                }
              }
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: Center(
        child: FutureBuilder<Place?>(
            future: place = HttpService().getPlaceById(placeId),
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data!.chores!.first.choreName);
              }else{
                return Text('');
              }
            }
        ),
      ),
    );
  }
}

