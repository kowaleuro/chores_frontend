import 'package:chores/core/http_service.dart';
import 'package:chores/models/Chore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({Key? key}) : super(key: key);

  static const routeName = '/GeneratingScreen';

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();


}

class _GeneratingScreenState extends State<GeneratingScreen> {

  late int placeId;
  Future<List<Chore>?>? chores;



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
    //_groupedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)) as LinkedHashMap<DateTime, List<Chore>>?;
  }

  Future<List<Chore>?> getGeneratedChores(int placeId) async {
    var data = await HttpService().getGeneratedChores(placeId);
    return data;
  }

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
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        reverse: false,
                        itemBuilder: (context, index) =>
                            ListTile(
                            title: Text(snapshot.data?[index].choreName ?? "got null"),
                              subtitle:
                              Text(DateFormat('EEE, MMM d, ''yy' ).format(snapshot.data?[index].when as DateTime)),
                              trailing: IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.highlight_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    snapshot.data?.removeAt(index);
                                  });
                                },),
                          ),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 40,),
                        itemCount: snapshot.data!.length,),
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
