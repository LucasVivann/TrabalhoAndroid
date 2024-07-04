import 'package:flutter/material.dart';
import 'package:trabalho/infra/repository/sqlite_repository.dart';

import '../components/es_container.dart';

class CadastroServicosPage extends StatefulWidget {
  const CadastroServicosPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroServicosPage> createState() => _CadastroServicosPageState();
}

class _CadastroServicosPageState extends State<CadastroServicosPage> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController horasController = TextEditingController();
  TextEditingController valorUnitarioController = TextEditingController();

  String? clienteSelecionado;
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

  void salvar() async {
    final descricao = descricaoController.text;
    final data = dataController.text;
    final horas = int.tryParse(horasController.text) ?? 0;
    final valorUnitario = double.tryParse(valorUnitarioController.text) ?? 0.0;

    if (clienteSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione um cliente')),
      );
      return;
    }

    await SQLiteRepository.saveServico(
        clienteSelecionado!, descricao, data, horas, valorUnitario);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Serviço cadastrado com sucesso!')),
    );

    descricaoController.clear();
    dataController.clear();
    horasController.clear();
    valorUnitarioController.clear();
    setState(() {
      clienteSelecionado = null;
    });
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
          DropdownButtonFormField<String>(
            value: clienteSelecionado,
            hint: Text('Selecione um Cliente'),
            onChanged: (String? newValue) {
              setState(() {
                clienteSelecionado = newValue;
              });
            },
            items: clientes
                .map<DropdownMenuItem<String>>((Map<String, dynamic> cliente) {
              return DropdownMenuItem<String>(
                value: cliente['nome'],
                child: Text(cliente['nome']),
              );
            }).toList(),
          ),
          TextFormField(
            controller: descricaoController,
            decoration: const InputDecoration(hintText: 'Descrição do Serviço'),
          ),
          TextFormField(
            controller: dataController,
            decoration: const InputDecoration(hintText: 'Data'),
          ),
          TextFormField(
            controller: horasController,
            decoration: const InputDecoration(hintText: 'Quantidade de Horas'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: valorUnitarioController,
            decoration: const InputDecoration(hintText: 'Valor Unitário'),
            keyboardType: TextInputType.number,
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
