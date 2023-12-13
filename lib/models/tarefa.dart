import 'package:flutter_db/utils/database_helper.dart';

class Tarefa {
  int? id;
  String descricao;

  Tarefa({
    this.id,
    required this.descricao,
  });

  Future<Tarefa> create() async {
    final instance = await DatabaseHelper.instance.database;
    id = await instance.insert('tarefas', {'descricao': descricao});
    return this;
  }

  Future<Tarefa> update({ String? descricao }) async {
    final instance = await DatabaseHelper.instance.database;
    await instance.update('tarefas', {'descricao': descricao}, where: 'id = ?', whereArgs: [id]);
    this.descricao = descricao.toString();
    return this;
  }

  Future<void> delete() async {
    final instance = await DatabaseHelper.instance.database;
    await instance.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Tarefa>> get() async {
    final instance = await DatabaseHelper.instance.database;
    final tarefas = await instance.query('tarefas');
    return tarefas.map((t) => Tarefa(id: int.parse(t['id'].toString()), descricao: t['descricao'].toString()),).toList();
  }
}
