import 'package:flutter/material.dart';

import '../../../api/users_api.dart';
import '../model/user.dart';

class UserLocalScreen extends StatelessWidget {
  const UserLocalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
            future: UsersApi.getUsersLocally(context),
            builder: (context,snapshot) {
              final users = snapshot.data;

              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if(snapshot.hasError) {
                    return const Center(child: Text('Some Error'));
                  } else{
                    return buildUsers(users);
                  }
              }
            },
      ),
    );
  }

  Widget buildUsers(List<User>? users) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users!.length,
      itemBuilder: (context, i) {
        final user = users[i];
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(user.urlAvatar)),
          title: Text(user.username),
          subtitle: Text(user.email),
        );
      }
  );
}
