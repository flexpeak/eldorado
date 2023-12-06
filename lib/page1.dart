import 'package:flutter/material.dart';
import 'package:flutter_db/page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _darkMode = false;

  _changeDarkModeValue(newValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', newValue);
    setState(() {
      _darkMode = newValue;
    });
  }

  _getDarkModeValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') == null ? false : prefs.getBool('darkMode')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banco de Dados'),
        actions: [
          Row(
            children: [
              const Icon(Icons.sunny),
              Switch(
                value: _darkMode,
                onChanged: _changeDarkModeValue,
              ),
              const Icon(Icons.nightlight)
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Hello World!'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const Page2(),
                ));
              },
              child: const Text('Ir para página 2'),
            )
          ],
        ),
      ),
    );
  }
}
