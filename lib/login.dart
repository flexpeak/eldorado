// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_db/inicio.dart';
import 'package:flutter_db/providers/token_provider.dart';
import 'package:flutter_db/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Image.network(
                'https://static-00.iconduck.com/assets.00/user-login-icon-1948x2048-nocsasoq.png',
                width: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 50,
              ),
              FilledButton(
                onPressed: () async {
                  final key = dotenv.env['FIREBASE_KEY'];
                  final response = await http.post(
                    Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key"),
                    body: jsonEncode({'email': _emailController.text, 'password': _passwordController.text, 'returnSecureToken': true}),
                  );

                  if (response.statusCode == 200) {
                    final responseData = jsonDecode(response.body);
                    final token = responseData['idToken'];
                    Provider.of<TokenProvider>(context, listen: false).setToken(token);

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => const Inicio()),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Fazer Login'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: const Text('Registrar-se'))
            ],
          ),
        ),
      ),
    );
  }
}
