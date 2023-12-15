import 'package:flutter/material.dart';
import 'package:flutter_db/register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                child: const Text('Fazer Login'),
              ),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              }, child: const Text('Registrar-se'))
            ],
          ),
        ),
      ),
    );
  }
}
