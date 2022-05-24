import 'package:chores/core/http_service.dart';
import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../components/background.dart';


class ShowUsersScreen extends StatefulWidget {
  const ShowUsersScreen({Key? key}) : super(key: key);

  static const routeName = '/ShowUsersScreen';

  @override
  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {

  late int placeId;
  Future<List<User>?>? users;

  @override
  void initState() {
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
        var usersData = getUsers(placeId);
        setState(() {
          users =usersData;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
        ),
        body: Background(
            child: SingleChildScrollView(
              child: FutureBuilder<List<User>?>(
                  future: users,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      return ListView.separated(
                          shrinkWrap: true,
                          reverse: false,
                          itemBuilder: (context, index) =>
                              Center(
                                child: Center(
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data?[index].nickname ?? "got null",
                                    ),
                                    subtitle: Text(
                                      snapshot.data?[index].email ?? "got null",
                                    ),
                                    trailing: IconButton(
                                      color: Colors.red,
                                      icon: const Icon(Icons.highlight_off_outlined),
                                      onPressed: () {
                                        unSubscribe(snapshot.data?[index].email ?? '');
                                      },),
                                  ),
                                ),
                              )
                          , separatorBuilder: (contex, index) => const SizedBox(height: 40,)
                          , itemCount: snapshot.data!.length);
                    }else{
                      return const Text('');
                    }
                  }
              ),
            )

        )

    );
  }
  void unSubscribe(String email) async{
    await HttpService().unsubscribeUserFromPlace(email, placeId);
    setState(() {
      print('fdfd');
      users = getUsers(placeId);
    });
  }
  Future<List<User>?> getUsers(int placeId) async {
    var data = await HttpService().getUsersOfPlace(placeId);
    return data;
  }
}

