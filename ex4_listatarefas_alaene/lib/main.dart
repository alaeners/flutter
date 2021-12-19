// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

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
  var showTasks = [];
  var listCheckBox = [];
  var verifyCheckBox = false;

  late TextEditingController myControllerDialog;

  @override
  void initState() {
    super.initState();
    myControllerDialog = TextEditingController();
  }

  @override
  void dispose() {
    myControllerDialog.dispose();
    super.dispose();
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

    listCheckBox.clear();
    for (var task in tasks) {
      listCheckBox.add(CheckboxListTile(
        title: Text(task['descricao'].toString()),
        secondary: Icon(Icons.access_alarm),
        controlAffinity: ListTileControlAffinity.leading,
        value: task["status"] == "T",
        selectedTileColor: Colors.amberAccent,
        onChanged: (bool? newStatus) {
          if (task["status"] == "T") {
            _excluirTask(task['id'] as int);
          } else {
            _atualizarTask(task['id'] as int, newStatus as bool ? "T" : "F");
          }
          _listarTasks().then((dynamic f) {
            setState(() {});
          });
        },
      ));
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

  Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Digite a sua tarefa"),
            content: TextField(
              decoration: InputDecoration(hintText: "Nova Tarefa"),
              controller: myControllerDialog,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _salvar(myControllerDialog.text);
                    myControllerDialog.text = "";
                    Navigator.of(context).pop();
                    _listarTasks().then((dynamic f) {
                      setState(() {});
                    });
                  },
                  child: Text("Salvar"))
            ],
          ));

  @override
  StatefulWidget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Lista de Tarefas")),
        bottom: PreferredSize(
            child: Text(
              "Dicas: \n1. Clique para atualizar o check \n2. Se desejar excluir clique novamente na tarefa marcada.",
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
            preferredSize: const Size.fromHeight(48.0)),
      ),
      body: ListView.builder(
        itemCount: listCheckBox.length,
        itemBuilder: (context, index) {
          return listCheckBox[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        tooltip: 'Crie sua nova tarefa aqui',
        child: const Icon(Icons.add),
      ),
    );
  }
}
