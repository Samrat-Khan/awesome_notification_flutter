import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Show "),
          onPressed: () {},
        ),
      ),
    );
  }
}
