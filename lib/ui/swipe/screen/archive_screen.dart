import 'package:flutter/material.dart';

import '../model/chat.dart';

class ArchiveScreen extends StatefulWidget {
  final List<Chat> data;

  const ArchiveScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context,index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(widget.data[index].urlAvatar),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data[index].username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.data[index].message)
                ],
              ),
              onTap: () {},
            );
          },
      ),
    );
  }
}
