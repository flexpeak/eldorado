import 'package:flutter/material.dart';
import 'package:flutter_db/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {

  const Page2({super.key});

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
