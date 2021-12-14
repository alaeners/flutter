// ignore_for_file: file_names
import 'package:flutter/material.dart';

class DescriptionContact extends StatefulWidget {
  const DescriptionContact({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<DescriptionContact> createState() => _DescriptionContact();
}

class _DescriptionContact extends State<DescriptionContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text(
          'This is a new screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
