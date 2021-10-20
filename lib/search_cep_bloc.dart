import 'dart:async';

import 'package:my_project/model/cep_model.dart';
import 'package:my_project/search_cep_repository.dart';

class SearchCepBloc {
  SearchCepRepository repository = SearchCepRepository();

  final StreamController<String> _blocController = StreamController<String>();
  Sink get input => _blocController.sink;
  Stream<CepModel> get output =>
      _blocController.stream.asyncMap((cep) => repository.cepResponse(cep));

  fecharStream() {
    _blocController.close();
  }
}
