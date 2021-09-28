import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClass {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      String name, String logradouro, String bairro, String cep) async {
    await users.add(
        {'nome': name, 'logradouro': logradouro, 'bairro': bairro, 'cep': cep});
  }
}
