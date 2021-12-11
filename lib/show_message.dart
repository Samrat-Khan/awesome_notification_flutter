import 'package:flutter/material.dart';

class ShowMessage extends StatefulWidget {
  final Map<String, dynamic> message;
  const ShowMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  _ShowMessageState createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowMessage'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.message['message'] ?? "Message Empty",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              widget.message['title'] ?? "Body Empty",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
