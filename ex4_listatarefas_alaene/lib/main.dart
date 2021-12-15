// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var checkboxStatus = false;
  var showTasks = [];

  _openConection() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, descricao VARCHAR, status BIT) ";
      db.execute(sql);
    });

    return bd;
  }

  _salvar(String descricao) async {
    Database bd = await _openConection();
    Map<String, dynamic> task = {"descricao": descricao, "status": false};
    int id = await bd.insert("tasks", task);
  }

  _listarTasks() async {
    Database bd = await _openConection();
    String sql = "SELECT * FROM tasks "; //ASC, DESC
    List tasks = await bd.rawQuery(sql);

    for (var task in tasks) {
      showTasks.add(task);
    }
  }

  _excluirTask(int id) async {
    Database bd = await _openConection();
    int retorno = await bd.delete("tasks", where: "id = ?", whereArgs: [id]);
  }

  _atualizarTask(int id, bool status) async {
    Database bd = await _openConection();

    Map<String, bool> dadosTask = {"status": status};
    int retorno = await bd
        .update("tasks", dadosTask, where: "id = ?", whereArgs: [id]);
  }

    void _incrementTask() {
    setState(() {
      _salvar("asdjaskldjaksljdkasjdkasjdklasjkdjaskld");
      _listarTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Lista de Tarefas")),
      ),
      body: ListView.builder(
        itemCount: showTasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(showTasks[index]['descricao'].toString()),
            secondary: Icon(Icons.alarm),
            controlAffinity: ListTileControlAffinity.leading,
            value: checkboxStatus,
            onChanged: (bool? newStatus) {
              checkboxStatus = newStatus as bool;
            },
          );
        },
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementTask,
          tooltip: 'Increment task',
          child: const Icon(Icons.add),
          
      ),
    );
  }
}