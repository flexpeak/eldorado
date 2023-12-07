import 'package:flutter/material.dart';
import 'package:flutter_db/page2.dart';
import 'package:flutter_db/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banco de Dados'),
        actions: [
          Row(
            children: [
              const Icon(Icons.sunny),
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
                return Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (newValue) {
                    themeProvider.changeDarkMode(newValue);
                  },
                );
              }),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Page2(),
                  ),
                );
              },
              child: const Text('Ir para página 2'),
            )
          ],
        ),
      ),
    );
  }
}
