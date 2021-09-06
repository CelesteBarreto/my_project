import 'dart:async';

import 'package:flutter/material.dart';


class MyHomePageBloc {
  int _total = 0;
  int get total => _total;

  final _blocController = StreamController<int>();
  Stream<int> get minhaStream => _blocController.stream;

  void incrementar() {
    _total++;
    _blocController.sink.add(total);
  }

  fecharStream() {
    _blocController.close();
  }

}
