/* import 'package:flutter/material.dart';
import 'package:my_project/bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: bloc.minhaStream,
              initialData: 0,
              builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("Há um erro na Stream");
              } else{
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              }
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementar,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override 
  void dispose() {
      bloc.fecharStream();
      super.dispose();
  }
}
 */

import 'package:flutter/material.dart';
import 'package:my_project/model/cep_model.dart';
import 'package:my_project/search_cep_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchCepBloc blocCEP = SearchCepBloc();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();

  @override
  void dispose() {
    //blocCEP.debounce?.cancel();
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
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError && snapshot.error is Exception) {
                    return Text(snapshot.error.toString());
                  }
                  else if (snapshot.hasError) {
                    return Text('Erro feio');
                  }
                  CepModel? cepModel = snapshot.data;
                  logradouroController.text = cepModel!.bairro ?? 'logradouro inexistente';
                  ruaController.text = cepModel.logradouro ?? 'Bairro inexistente';
                  return Column(
                    children: [
                      Text(cepModel.logradouro ?? 'sem logradouro'),
                      TextFormField(
                        onChanged: (value) => {},
                        decoration: InputDecoration(labelText: 'Nome', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: ruaController,
                        decoration: InputDecoration(labelText: 'Logradouro', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: logradouroController,
                        decoration: InputDecoration(labelText: 'Bairro', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Salvar'))
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
