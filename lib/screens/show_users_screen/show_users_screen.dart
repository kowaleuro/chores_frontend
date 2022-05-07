import 'package:chores/core/http_service.dart';
import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../components/background.dart';

class ShowUsersScreen extends StatelessWidget {
  const ShowUsersScreen({Key? key}) : super(key: key);

  static const routeName = '/ShowUsersScreen';

  @override
  Widget build(BuildContext context) {
    late int placeId;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 56, 135, 1),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: FutureBuilder<List<User>?>(
            future: HttpService().getUsersOfPlace(placeId),
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
                              )
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
}

