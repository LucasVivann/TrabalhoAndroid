import 'package:flutter/material.dart';
import 'package:trabalho/infra/repository/sqlite_repository.dart';

class ListaClientesPage extends StatefulWidget {
  const ListaClientesPage({super.key, required this.title});

  final String title;

  @override
  State<ListaClientesPage> createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  List<Map<String, dynamic>> clientes = [];

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    final data = await SQLiteRepository.getClientes();
    setState(() {
      clientes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          return ListTile(
            title: Text(cliente['nome']),
            subtitle: Text(
                'Documento: ${cliente['documento']}\nTelefone: ${cliente['telefone']}\nEmail: ${cliente['email']}'),
          );
        },
      ),
    );
  }
}
