import 'package:flutter/material.dart';
import 'package:trabalho/pages/CadastroClientesPage.dart';
import 'package:trabalho/pages/CadastroServicosPage.dart';

import 'lista_clientes_page.dart';

import 'lista_servicos_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CadastroClientesPage(title: 'Cadastro de Clientes'),
                  ),
                );
              },
              child: Text('Cadastrar Cliente'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListaClientesPage(title: 'Lista de Clientes'),
                  ),
                );
              },
              child: Text('Lista de Clientes'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CadastroServicosPage(title: 'Cadastro de Serviços'),
                  ),
                );
              },
              child: Text('Cadastrar Serviço'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListaServicosPage(title: 'Lista de Serviços'),
                  ),
                );
              },
              child: Text('Lista de Serviços'),
            ),
          ],
        ),
      ),
    );
  }
}
