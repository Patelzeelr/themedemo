import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_demo/provider/theme_provider.dart';

import '../../../localization/languages/languages.dart';
import '../../../localization/locale_constants.dart';
import '../../../widgets/dismissible_widget.dart';
import '../model/chat.dart';
import '../model/data.dart';
import 'archive_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Chat> items = List.of(Data.chats);
  List<Chat> newItems = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: () {
              setState(() {
                items = List.of(Data.chats);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                _showLanguageDialog();
              });
            },
          ),
          Switch.adaptive(
              activeColor: Colors.white,
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArchiveScreen(data: newItems)));
        },
        child: const Icon(Icons.archive),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return DismissibleWidget(
            item: item,
            child: buildListTile(item),
            onDismissed: (direction) => dismissItem(context, index, direction),
          );
        },
      ),
    );
  }

  void dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) {
    // setState(() {
    //   items.removeAt(index);
    // });

    switch (direction) {
      case DismissDirection.endToStart:
        items.removeAt(index);
        Utils.showSnackBar(context, 'Chat has been deleted');
        break;
      case DismissDirection.startToEnd:
        newItems.add(Chat(
            urlAvatar: items[index].urlAvatar,
            username: items[index].username,
            message: items[index].message));
        Utils.showSnackBar(context, 'Chat has been archived');
        break;
      default:
        break;
    }
  }

  Widget buildListTile(Chat item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(item.urlAvatar),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.message),
          ],
        ),
        onTap: () {},
      );

  _showLanguageDialog() => showDialog<Void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  changeLanguage(context, 'en');
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Text('🇺🇸'),
                    SizedBox(width: 10.0),
                    Text('English'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  changeLanguage(context, 'hi');
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Text('🇮🇳'),
                    SizedBox(width: 10.0),
                    Text('हिन्दी'),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

class Utils {
  static void showSnackBar(BuildContext context, String message) =>
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
}