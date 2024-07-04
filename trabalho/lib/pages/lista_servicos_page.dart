import 'package:flutter/material.dart';
import 'package:trabalho/infra/repository/sqlite_repository.dart';

class ListaServicosPage extends StatefulWidget {
  const ListaServicosPage({super.key, required this.title});

  final String title;

  @override
  State<ListaServicosPage> createState() => _ListaServicosPageState();
}

class _ListaServicosPageState extends State<ListaServicosPage> {
  List<Map<String, dynamic>> servicos = [];

  @override
  void initState() {
    super.initState();
    _loadServicos();
  }

  Future<void> _loadServicos() async {
    final data = await SQLiteRepository.getServicos();
    setState(() {
      servicos = data;
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
        itemCount: servicos.length,
        itemBuilder: (context, index) {
          final servico = servicos[index];
          return ListTile(
            title: Text(servico['cliente']),
            subtitle: Text(
              'Descrição: ${servico['descricao']}\n'
              'Data: ${servico['data']}\n'
              'Quantidade de Horas: ${servico['horas']}\n'
              'Valor Unitário: ${servico['valor_unitario']}\n'
              'Valor Total: ${servico['valor_total']}',
            ),
          );
        },
      ),
    );
  }
}
