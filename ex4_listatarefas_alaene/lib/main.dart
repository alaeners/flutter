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

  createAlertDialog(BuildContext context) {
    TextEditingController myDialogController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Insira sua nova tarefa aqui"),
            content: TextField(
              controller: myDialogController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Salvar"),
                onPressed: (_salvar(myDialogController.text)),
              )
            ],
          );
        });
  }

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

  _incrementTask() {
    setState(() {
      _salvar("Salvando Tudo, mas salva pelo increment");
      //_listarTasks();
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
            secondary: Icon(Icons.time_to_leave),
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
        onPressed: createAlertDialog(context),
        tooltip: 'Crie sua nova tarefa aqui',
        child: const Icon(Icons.add),
      ),
    );
  }
}
