import 'package:dio/dio.dart';
import 'package:my_project/model/cep_model.dart';

class SearchCepRepository {
  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/';

  Future<CepModel> cepResponse(String cep) async {
    if (cep.length == 8) {
      Response response = await Dio().get(url(cep));
      return CepModel.fromJson(response.data);
    } else {
      throw Exception('Aguardando a informação completa');
    }
  }
}
