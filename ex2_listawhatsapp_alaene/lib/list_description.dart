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
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          centerTitle: true),
      body: const Center(
        child: Text(
          ' OBJETIVO AQUI: Ao clicar no contato ele deve ir para uma outra página que exiba no appBar o nome do contato. ',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
