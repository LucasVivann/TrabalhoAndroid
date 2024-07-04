import 'package:flutter/material.dart';
import 'package:trabalho/pages/CadastroClientesPage.dart';
import 'package:trabalho/pages/CadastroServicosPage.dart';
import 'package:trabalho/pages/home.dart';
import 'package:trabalho/pages/lista_clientes_page.dart';
import 'package:trabalho/pages/lista_servicos_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Clientes e Serviços',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/cadastro_clientes': (context) =>
            CadastroClientesPage(title: 'Cadastro de Clientes'),
        '/lista_clientes': (context) =>
            ListaClientesPage(title: 'Lista de Clientes'),
        '/cadastro_servicos': (context) =>
            CadastroServicosPage(title: 'Cadastro de Serviços'),
        '/lista_servicos': (context) =>
            ListaServicosPage(title: 'Lista de Serviços'),
      },
    );
  }
}
