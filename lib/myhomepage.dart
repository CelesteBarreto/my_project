import 'package:flutter/material.dart';
import 'package:my_project/bd/firebase/firebase.dart';
import 'package:my_project/login_page.dart';
import 'package:my_project/model/cep_model.dart';
import 'package:my_project/search_cep_bloc.dart';
import 'package:my_project/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String? streetText;
  FirebaseClass firebase = FirebaseClass();
  SearchCepBloc blocCEP = SearchCepBloc();
  TextEditingController districtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  SharedPreferencesClass shared = SharedPreferencesClass();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      //var cep = await shared.getValues('cep');
      var user = await shared.getValues('user');

      nameController.text = user['nome'] ?? '';
      districtController.text = user['district'] ?? '';
      streetController.text = user['street'] ?? '';
    });
  }

  @override
  void dispose() {
    blocCEP.fecharStream();
    streetController.dispose();
    cepController.dispose();
    districtController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.create))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: cepController,
              decoration: InputDecoration(hintText: 'Digite o cep'),
              onChanged: (value) {
                blocCEP.input.add(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<CepModel>(
              stream: blocCEP.output,
              builder: (context, snapshot) {
                /* if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } */
                if (snapshot.hasError && snapshot.error is Exception) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasError) {
                  return Text('Erro feio');
                }
                CepModel? cepModel =
                    snapshot.data; //? pode ser nulo. ! não pode ser nulo
                districtController.text =
                    cepModel?.bairro ?? 'logradouro inexistente';
                streetController.text =
                    cepModel?.logradouro ?? 'Bairro inexistente';
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 2)
                            return 'Preencha o campo corretamente';
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 2)
                            return 'Preencha o campo corretamente';
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 2)
                            return 'Preencha o campo corretamente';
                          return null;
                        },
                        controller: senhaController,
                        decoration: InputDecoration(
                            labelText: 'senha',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10)
                            return 'Campo inválido';
                          return null;
                        },
                        controller: streetController,
                        decoration: InputDecoration(
                            labelText: 'Logradouro',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10)
                            return 'Campo inválido';
                          return null;
                        },
                        controller: districtController,
                        decoration: InputDecoration(
                            labelText: 'Bairro',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                Map user = {
                                  'nome': nameController.text,
                                  'district': districtController.text,
                                  'street': streetController.text,
                                  'cep': cepController.text
                                };

                                await shared.saveData('user', user);

                                firebase.addUser(
                                    nameController.text,
                                    districtController.text,
                                    streetController.text,
                                    cepController.text);

                                /* ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing data'))); */
                                Future.delayed(Duration(milliseconds: 2));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              }
                            },
                            child: Text('Salvar')),
                      ),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () async {
                              var user = await shared.getValues('user');
                              await shared.deleteKey('user');
                            },
                            child: Text('Delete User')),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
