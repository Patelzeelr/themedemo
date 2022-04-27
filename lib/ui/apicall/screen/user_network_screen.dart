import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theme_demo/ui/apicall/model/data_model.dart';
import '../../../api/users_api.dart';
import '../model/data_update_model.dart';
import '../model/user.dart';

class UserNetworkScreen extends StatefulWidget {
  const UserNetworkScreen({Key? key}) : super(key: key);

  @override
  State<UserNetworkScreen> createState() => _UserNetworkScreenState();
}

Future<DataModel?> submitData(String name, String job) async{
  var response = await http.post(Uri.https('reqres.in', 'api/users'),body: {
    "name": name,
    "job": job,
  });
  var data = response.body;
  print(data);
  if(response.statusCode == 201) {
    String responseString = response.body;
    dataModelFromJson(responseString);
  }
  else {return null;}
}

Future<DataModel?> updateData(String name, String job) async{
  var response = await http.put(Uri.https('reqres.in', 'api/users/2'),body: {
    "name": name,
    "job": job,
  });
  var data = response.body;
  print(data);
  if(response.statusCode == 200) {
    String responseString = response.body;
    dataUpdateModelFromJson(responseString);
  }
  else {return null;}
}

class _UserNetworkScreenState extends State<UserNetworkScreen> {
  late DataModel _dataModel;
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: UsersApi.getUser(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () { _postContainer(); },
      ),
    );
  }

  Widget buildUsers(List<User>? users) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users!.length,
      itemBuilder: (context, i) {
        final user = users[i];
        return ListTile(
          onTap: () => _showUserDetails(user),
          leading: CircleAvatar(backgroundImage: NetworkImage(user.urlAvatar)),
          title: Text(user.username),
          subtitle: Text(user.email),
        );
      }
  );
  _postContainer() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Data"),
          content: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name Here:'
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Job Here:'
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async{
                      String name = nameController.text;
                      String job = jobController.text;

                      DataModel? data = await submitData(name, job);
                      setState(() {
                        _dataModel = data!;
                      });
                    },
                    child: const Text('Submit')),
                ElevatedButton(
                    onPressed: () async{
                      String name = nameController.text;
                      String job = jobController.text;

                      DataUpdateModel? data = (await updateData(name, job)) as DataUpdateModel?;
                      setState(() {
                        _dataModel = data! as DataModel;
                      });
                    },
                    child: const Text('Update'),)
              ],
            ),
          ),
        );
      }
  );
      
  _showUserDetails(User user) => showDialog<Void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Detail'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                  CircleAvatar(backgroundImage: NetworkImage(user.urlAvatar)),
                  const SizedBox(height: 10.0),
                  Text(user.username,style: const TextStyle(fontSize:20.0,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10.0),
                  Text(user.email),
                  ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text('SEND MAIL'))
              ]
          ),
        );
      });
}
