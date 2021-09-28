import 'package:flutter/material.dart';
import 'package:my_project/bd/firebase/firebase.dart';
import 'package:my_project/model/cep_model.dart';
import 'package:my_project/search_cep_bloc.dart';
import 'package:my_project/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? streetText;
  FirebaseClass firebase = FirebaseClass();
  SearchCepBloc blocCEP = SearchCepBloc();
  TextEditingController districtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  SharedPreferencesClass shared = SharedPreferencesClass();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      //var cep = await shared.getValues('cep');
      var user = await shared.getValues('user');

      //
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
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
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
                          if (value!.isNotEmpty && value.length < 20)
                            return null;
                          return 'Campo inválido';
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
                          if (value!.isNotEmpty && value.length < 20)
                            return null;
                          return 'Campo inválido';
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
                            },
                            child: Text('Salvar')),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              var user = await shared.getValues('user');
                              await shared.deleteKey('user');
                            },
                            child: Text('Delete User')),
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
