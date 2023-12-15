import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                'Registrar-se',
                style: TextStyle(fontSize: 40),
              ),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Senha'),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 50,
              ),
              FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Registrar-se'),
              ),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              }, child: const Text('Voltar para Login'))
            ],
          ),
        ),
      ),
    );
  }
}