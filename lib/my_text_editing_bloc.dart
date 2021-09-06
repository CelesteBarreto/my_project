import 'dart:async';


class TextEditingBloc {


  //final TextEditingController _textController = TextEditingController(text: 'hello');
  final StreamController<String> _textController = StreamController<String>();
  Sink<String> get input => _textController.sink;
  Stream<String> get output => _textController.stream;


  fecharStream(){
    _textController.close();
  }

}
