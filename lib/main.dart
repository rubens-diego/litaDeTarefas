import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();

    return file.writeAsString(data);
  }

  Future<String> _readfile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return 'null';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefa"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('ADD'),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: _toDoList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: _toDoList[index]['ok'],

 onChanged: (bool? value) {
       
        },

                      title: Text(_toDoList[index]['title'] ),
                      
                      secondary: CircleAvatar(
                        child: Icon(_toDoList[index]['ok'] ? Icons.check : Icons.error),
                      )
                     );
                  }))
        ],
      ),
    );
  }
}
