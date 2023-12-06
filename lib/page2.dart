import 'package:flutter/material.dart';
import 'package:flutter_db/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page2 extends StatefulWidget {

  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
      _darkMode = prefs.getBool('darkMode') == null 
        ? false 
        : prefs.getBool('darkMode')!;
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
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (newValue) {
                      themeProvider.changeDarkMode(newValue);
                    },
                  );
                }
              ),
              const Icon(Icons.nightlight)
            ],
          )
        ],
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
