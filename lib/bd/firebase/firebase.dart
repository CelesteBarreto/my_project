import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseClass {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String name, String logradouro, String bairro) async {
    
    await users.add(
    {
      'nome': name,
      'logradouro':logradouro, 
      'bairro':bairro
    });
  }  
}


