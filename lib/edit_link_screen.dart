import 'package:flutter/material.dart';

class EditLinkScreen extends StatefulWidget {
  final String title;
  final String currentLink;
  final ValueChanged<String> onSave;

  EditLinkScreen({
    required this.title,
    required this.currentLink,
    required this.onSave,
  });

  @override
  _EditLinkScreenState createState() => _EditLinkScreenState();
}

class _EditLinkScreenState extends State<EditLinkScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentLink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Link'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.onSave(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Video Link'),
            ),
          ],
        ),
      ),
    );
  }
}
