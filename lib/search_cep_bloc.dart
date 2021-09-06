import 'dart:async';

import 'package:dio/dio.dart';

import 'package:my_project/model/cep_model.dart';

class SearchCepBloc {
 
  final StreamController<String> _blocController = StreamController<String>();
  Sink get input => _blocController.sink;
  Stream<CepModel> get output => _blocController.stream.asyncMap((cep) => cepResponse(cep));

  fecharStream() {
    _blocController.close();
  }

  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/';

  Future<CepModel> cepResponse(String cep) async {
  if(cep.length == 8){
    Response response = await Dio().get(url(cep));
   return CepModel.fromJson(response.data);
  }
   else{
     throw Exception('Cep inválido');
   }
  }
}
