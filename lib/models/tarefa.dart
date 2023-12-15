import 'dart:convert';

import 'package:flutter_db/utils/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sql.dart';

class Tarefa {
  String? id;
  String descricao;

  Tarefa({
    this.id,
    required this.descricao,
  });

  Future<Tarefa> create() async {
    final instance = await DatabaseHelper.instance.database;

    final response = await http.post(
      Uri.parse("https://curso-eldorado-default-rtdb.firebaseio.com/tarefas.json"),
      body: jsonEncode({"descricao": descricao}),
    );

    final responseData = jsonDecode(response.body);

    id = responseData['name'];
    await instance.insert(
      'tarefas',
      {'id': id, 'descricao': descricao},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    return this;
  }

  Future<Tarefa> update({String? descricao}) async {
    final instance = await DatabaseHelper.instance.database;
    await instance.update('tarefas', {'descricao': descricao}, where: 'id = ?', whereArgs: [id]);
    this.descricao = descricao.toString();

    http.put(Uri.parse("https://curso-eldorado-default-rtdb.firebaseio.com/tarefas/$id.json"), body: jsonEncode({'descricao': descricao}));

    return this;
  }

  Future<void> delete() async {
    final instance = await DatabaseHelper.instance.database;
    await instance.delete('tarefas', where: 'id = ?', whereArgs: [id]);

    http.delete(Uri.parse("https://curso-eldorado-default-rtdb.firebaseio.com/tarefas/$id.json"));
  }

  static Future<List<Tarefa>> get() async {
    final instance = await DatabaseHelper.instance.database;

    final response = await http.get(
      Uri.parse("https://curso-eldorado-default-rtdb.firebaseio.com/tarefas.json"),
    );
    final Map responseData = jsonDecode(response.body);
    if (responseData != "null") {
      responseData.forEach((id, tarefa) async {
        await instance.insert(
          'tarefas',  
          {'id': id, 'descricao': tarefa['descricao']},
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      });
    }

    final tarefas = await instance.query('tarefas');
    return tarefas
        .map(
          (t) => Tarefa(id: t['id'].toString(), descricao: t['descricao'].toString()),
        )
        .toList();
  }
}
