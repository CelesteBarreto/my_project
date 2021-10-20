import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project/search_cep_repository.dart';

import 'search_cep_bloc_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  final repository = SearchCepRepository();
  String cep = '28013045';

  test('get cep', () async {
    when(dio.get(any)).thenAnswer((realInvocation) async => Response(
        data: jsonDecode(jsonData),
        requestOptions:
            RequestOptions(path: 'https://viacep.com.br/ws/$cep/json/')));
    final cepText = await repository.cepResponse(cep);
    print(cepText);
  });
}

String jsonData = ''' 
[{
  "cep": "28013-045",
  "logradouro": "Rua Padre Carmelo",
  "complemento": "",
  "bairro": "Parque Califórnia",
  "localidade": "Campos dos Goytacazes",
  "uf": "RJ",
  "ibge": "3301009",
  "gia": "",
  "ddd": "22",
  "siafi": "5819"
}]  ''';
