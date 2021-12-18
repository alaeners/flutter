// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, descricao VARCHAR, status VARCHAR) ";
      db.execute(sql);
    });

    return bd;
  }

  _salvar(String descricao) async {
    Database bd = await _openConection();
    Map<String, dynamic> task = {"descricao": descricao, "status": "F"};
    int id = await bd.insert("tasks", task);
  }

  _listarTasks() async {
    Database bd = await _openConection();
    String sql = "SELECT * FROM tasks "; //ASC, DESC
    List tasks = await bd.rawQuery(sql);

    showTasks.clear();
    for (var task in tasks) {
      showTasks.add(task);
    }
  }

  _excluirTask(int id) async {
    Database bd = await _openConection();
    int retorno = await bd.delete("tasks", where: "id = ?", whereArgs: [id]);
  }

  _atualizarTask(int id, String status) async {
    Database bd = await _openConection();

    Map<String, String> dadosTask = {"status": status};
    int retorno =
        await bd.update("tasks", dadosTask, where: "id = ?", whereArgs: [id]);
  }

  _incrementTask(BuildContext context) {
    setState(() {
      _showMaterialDialog(context);
      //insertText();
      //_salvar("Salvando Tudo, mas salva");
      //_listarTasks();
    });
  }

  void insertText() {
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("SALVAR"),
        onPressed: () {},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Lista de Tarefas"),
        content: TextField(
          decoration: InputDecoration(hintText: "Escreva aqui sua tarefa"),
        ),
        actions: [_salvar("Salvando por aqui")],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Material Dialog'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  Navigator.pop(context);
                },
                child: Text('HelloWorld!'),
              )
            ],
          );
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
          _listarTasks();
          return CheckboxListTile(
            title: Text(showTasks[index]['descricao'].toString()),
            secondary: Icon(Icons.delete),
            controlAffinity: ListTileControlAffinity.leading,
            value: checkboxStatus,
            selectedTileColor: Colors.amberAccent,
            onChanged: (bool? newStatus) {
              checkboxStatus = newStatus as bool;
              _atualizarTask(
                  showTasks[index]['id'] as int, newStatus ? "T" : "F");
              if (newStatus) {
                _excluirTask(showTasks[index]['id'] as int);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTask(context),
        tooltip: 'Crie sua nova tarefa aqui',
        child: const Icon(Icons.add),
      ),
    );
  }
}
