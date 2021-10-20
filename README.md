# my_project

## Descrição/Description
Um projeto de teste e desenvolvimento de funcionalidades. 
A test project and functionality developemnt.


<p align="center">
    <img width="350" height="625" src="assets/images/img_form_screen_2.png">
    <img width="350" height="625" src="assets/images/img_form_screen.png">
</p>

## Desenvolvimento/Development
- [x] Tela de Busca / Search Screen
- [x] Requisição de API externa / API request using an external reference
- [x] Gerência de estado com o Bloc puro / State management using Bloc
- [x] Salvar dados no Firebase / Save data in a Cloud Database
- [x] Salvar, retornar e deletar dados no Shared Preferences / Save, get data and remove data from SharedPreferences
- [x] Teste do Dio usando mockito / Test using Mockito 


## Aprendizado
- StreamController como um recebedor de dados sendo ele também disposado ao fim do seu uso.
- Dispose dos controllers e do bloc no dispose da HomePage
- Salvar dados no banco em nuvem
- Gerenciar a reatividade/estados através do bloc e gerenciar a entrada e saída de dados por meio do input, output e StreamController.
- Uso da StreamBuilder
- Importância dos controllers na StreamBuilder como forma de mostrar os valores nos campos
- O Shared Preferences sobrescreve os dados a serem salvos localmente. O Shared Preferences faz referencias aos dados por meio de chave e valor. Usar métodos como getKeys para retornar todasd as keys; prefs.remove() para remover uma key específica e os dados nela contidos.


Obs: para gerar a classe mock deve-se digitar o comando dart run build_runner build
Caso informe um erro de pubspec.yaml não encontrado, o comando dart pub get resolve.

<br>

## Próximos Passos
- Tela de Login / Login Screen
- Autenticação / Autentication
- Refatoração de código / Code Refactoring

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
