// ignore_for_file: file_names
import 'top_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          centerTitle: true),
      body: Column(
        children: const <Widget>[
          TopBar(),
        ],
      ),
    );
  }
}
