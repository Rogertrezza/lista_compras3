import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:lista_compras3/model/repos_lista.dart';
import 'package:lista_compras3/view/buscar.dart';
import 'package:lista_compras3/widgets/navBar.dart';

// Páginas para navegação
import 'view/index_tela.dart';
import 'view/login.dart';
import 'view/home.dart';
import 'view/cadastro.dart';
import 'view/recuperar_senha.dart';
import 'view/sobre.dart';
import 'package:lista_compras3/model/repos_usuario.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final UserRepository userRepository = UserRepository();

  final ListaDeComprasRepository listaDeComprasRepository = ListaDeComprasRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',
      //Rotas de navegação
      initialRoute: 'index_tela',
      routes: {
        'index_tela': (context) => index_tela(),
        'login': (context) => login(userRepository: userRepository),
        'home':(context) => home(),
        'cadastro':(context) => cadastro(userRepository: userRepository),
        'recuperar_senha':(context) => recuperar_senha(userRepository: userRepository),
        'navBar': (context) => navBar(),
        'sobre':(context) => sobre(),
        'buscar':(context) => buscaItem(listaDeComprasRepository: listaDeComprasRepository),
      },
    );
  }
}
