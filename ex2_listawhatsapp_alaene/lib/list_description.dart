// ignore_for_file: file_names
import 'package:flutter/material.dart';

class DescriptionContact extends StatelessWidget {
  const DescriptionContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Screen')),
      body: Center(
        child: Text(
          'This is a new screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
