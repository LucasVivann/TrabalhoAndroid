import 'package:flutter/material.dart';
import 'package:trabalho/infra/repository/sqlite_repository.dart';

import '../components/es_container.dart';

class CadastroClientesPage extends StatefulWidget {
  const CadastroClientesPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroClientesPage> createState() => _CadastroClientesPageState();
}

class _CadastroClientesPageState extends State<CadastroClientesPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController documentoController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void salvar() async {
    final nome = nomeController.text;
    final documento = documentoController.text;
    final telefone = telefoneController.text;
    final email = emailController.text;

    await SQLiteRepository.saveCliente(nome, documento, telefone, email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cliente cadastrado com sucesso!')),
    );

    nomeController.clear();
    documentoController.clear();
    telefoneController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(hintText: 'Nome'),
          ),
          TextFormField(
            controller: documentoController,
            decoration: const InputDecoration(hintText: 'Documento'),
          ),
          TextFormField(
            controller: telefoneController,
            decoration: const InputDecoration(hintText: 'Telefone'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: salvar,
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
