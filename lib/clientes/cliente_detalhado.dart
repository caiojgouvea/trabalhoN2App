import 'package:flutter/material.dart';
import 'package:flutter_app_svm/clientes/cliente_provider.dart';
import 'package:flutter_app_svm/modelos/cliente.dart';
import 'package:provider/provider.dart';

class ClienteDetalhamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cliente cliente = Provider.of<ClienteProvider>(context).clienteSelecionado;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhamento do Cliente'),
      ),
      body: Column(
        children: [
          Text('Cliente: ${cliente.descricao}'),
          Text('Código: ${cliente.codigo}'),
          Text('Cliente: ${cliente.descricao}'),
          Text('Cliente: ${cliente.descricao}'),
        ],
      ),
    );
  }
}
