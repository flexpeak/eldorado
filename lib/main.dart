// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_db/models/tarefa.dart';
import 'package:flutter_db/providers/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

Database? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await openDatabase(join(await getDatabasesPath(), 'tarefas.db'), version: 2, onCreate: (db, version) {
    return db.execute("CREATE TABLE tarefas(id integer primary key autoincrement, descricao text)");
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ThemeProvider>(context).getIsDarkModeFromSP(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            )),
          );
        }

        return MaterialApp(
          theme: ThemeData(useMaterial3: false),
          darkTheme: ThemeData.dark(useMaterial3: false),
          themeMode: snapshot.data! ? ThemeMode.dark : ThemeMode.light,
          home: Inicio(),
        );
      },
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({
    super.key,
  });

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final TextEditingController _tarefaController = TextEditingController();
  final _tarefas = [];

  @override
  void initState() {
    _getTarefasFromDB();
    super.initState();
  }

  _getTarefasFromDB() async {
    _tarefas.clear();
    _tarefas.addAll(await Tarefa.get());
    setState(() {});
  }

  _exibeFormulario(context, {Tarefa? tarefa}) {
    if (tarefa != null) {
      _tarefaController.text = tarefa.descricao;
    }

    showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          child: SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _tarefaController,
                    decoration: const InputDecoration(label: Text('Descrição da Tarefa')),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (tarefa == null) {
                        await Tarefa(
                          descricao: _tarefaController.text,
                        ).create();
                      } else {
                        await tarefa.update(descricao: _tarefaController.text);
                      }
              
                      Navigator.of(context).pop();
                      _getTarefasFromDB();
                    },
                    child: const Text('Salvar'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibeFormulario(context);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: List.generate(_tarefas.length, (index) {
              return ListTile(
                onLongPress: () async {
                  await _tarefas[index].delete();
                  _getTarefasFromDB();
                },
                onTap: () {
                  _exibeFormulario(
                    context,
                    tarefa: _tarefas[index],
                  );
                },
                leading: CircleAvatar(
                  child: Text(
                    _tarefas[index].id.toString(),
                  ),
                ),
                title: Text(_tarefas[index].descricao),
              );
            }),
          ),
        ),
      ),
    );
  }
}
