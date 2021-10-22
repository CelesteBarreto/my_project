import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                key: emailKey,
                validator: (String? value) {
                  if (value!.isEmpty) return 'Preencha o campo corretamente';
                  return null;
                },
                //controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) return 'Preencha o campo corretamente';
                  return null;
                },
                //controller: senhaController,
                decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: () async => formKey.currentState?.validate(),
                    child: Text('LOGIN')),
              ),
              TextButton(
                  onPressed: () async {
                    formKey.currentState?.reset();
                    await Future.delayed(Duration(seconds: 1));
                    emailKey.currentState?.validate();
                  },
                  child: Text('Esqueceu a senha?'))
            ],
          ),
        ),
      ),
    );
  }
}
