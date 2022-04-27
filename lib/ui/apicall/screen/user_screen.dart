import 'package:flutter/material.dart';
import 'package:theme_demo/ui/apicall/screen/user_local_screen.dart';
import 'package:theme_demo/ui/apicall/screen/user_network_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.teal,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Local'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Network'
          ),
        ],
        onTap: (int index) => setState(() => this.index = index),
      ),
      body: buildPages(),
    );
  }

    Widget buildPages() {
      switch (index) {
        case 0:
          return const UserLocalScreen();
        case 1:
          return const UserNetworkScreen();
        default:
          return Container();
      }
    }
}