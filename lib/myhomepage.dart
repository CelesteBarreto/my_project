import 'package:flutter/material.dart';
import 'package:my_project/bd/firebase/firebase.dart';
import 'package:my_project/model/cep_model.dart';
import 'package:my_project/search_cep_bloc.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? logradouroText;
  FirebaseClass firebase = FirebaseClass();
  SearchCepBloc blocCEP = SearchCepBloc();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  


  @override
  void dispose() {
    blocCEP.fecharStream();
    logradouroController.dispose();
    ruaController.dispose();
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
              decoration: InputDecoration(hintText: 'Digite o cep'),
              onChanged: (textController) {
                blocCEP.input.add(textController);
              },
            ),
            StreamBuilder<CepModel>(
              stream: blocCEP.output,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError && snapshot.error is Exception) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasError) {
                  return Text('Erro feio');
                }
                CepModel? cepModel = snapshot.data;
                logradouroController.text = cepModel!.bairro ?? 'logradouro inexistente';
                ruaController.text = cepModel.logradouro ?? 'Bairro inexistente';
                return Column(
                  children: [
                    Text(cepModel.logradouro ?? 'sem logradouro'),
                    TextFormField(
                      onSaved: (value) => nameController.text = value.toString(),
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isNotEmpty && value.length < 20) return null;
                        return 'Campo inválido';
                      },
                      onSaved: (value) => ruaController.text = value.toString(),
                      controller: ruaController,
                      decoration: InputDecoration(labelText: 'Logradouro', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isNotEmpty && value.length < 20) return null;
                        return 'Campo inválido';
                      },
                      onSaved: (value) => logradouroText = value,
                      controller: logradouroController,
                      decoration: InputDecoration(labelText: 'Bairro', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () async {
                           
                            firebase.addUser(nameController.text, logradouroController.text, ruaController.text);
                          },
                          child: Text('Salvar')),
                    )
                  ],
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
