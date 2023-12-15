// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_db/inicio.dart';
import 'package:flutter_db/login.dart';
import 'package:flutter_db/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          home: const Login(),
        );
      },
    );
  }
}

