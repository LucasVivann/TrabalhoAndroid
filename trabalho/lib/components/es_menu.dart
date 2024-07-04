import 'package:flutter/material.dart';

class ESMenu extends StatelessWidget {
  const ESMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/clientes');
          },
          child: const Text('Cadastro de Clientes')),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/lista_clientes');
          },
          child: const Text('Lista Clientes')),
    ]);
  }
}
