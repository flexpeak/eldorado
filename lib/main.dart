import 'package:flutter/material.dart';
import 'package:flutter_db/page1.dart';
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

class Inicio extends StatelessWidget {
  final TextEditingController _tarefaController = TextEditingController();
  Inicio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (c) {
                return Dialog(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        TextField(
                          controller: _tarefaController,
                          decoration: const InputDecoration(
                            label: Text('Descrição da Tarefa')
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final id = await database!.insert('tarefas', {
                              'descricao': _tarefaController.text
                            });
                            print(id);
                          },
                          child: const Text('Salvar'),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Página inicial'),
      ),
    );
  }
}
