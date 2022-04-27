import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imagePath = "";
  late File imageTemp;

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image != null
          ? ClipOval(
            child: Image.file(
                image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
            ),
          ) : const ClipOval(
            child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ94iyPvEu83dLqW7b-E6XFCEcCq5JzvMfGcg&usqp=CAU")),
          ),
          const SizedBox(height: 20.0),
          const Text('Select option for image'),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _iconContainer(Icons.image, () {
                _pickImage(ImageSource.gallery);
              }),
              _iconContainer(Icons.camera, () {
                _pickImage(ImageSource.camera);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconContainer(IconData icons, VoidCallback function) => Container(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 8.0)
          ],
        ),
        child: IconButton(
            onPressed: function, icon: Icon(icons), color: Colors.white),
      );

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {}
  }

}
