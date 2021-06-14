import 'package:flutter/material.dart';
import 'package:flutter_app_svm/clientes/cliente_provider.dart';
import 'package:flutter_app_svm/modelos/cliente.dart';
import 'package:flutter_app_svm/roteamento/rotas.dart';
import 'package:provider/provider.dart';

class ClienteTile extends StatelessWidget {
  final Cliente cliente;
  const ClienteTile(this.cliente);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide()),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text(
          '${cliente.descricao}',
        ),
        subtitle: Text('Código: ${cliente.codigo}\n${cliente.getCpfCnpj()}',
            style: TextStyle(fontWeight: FontWeight.w900)),
        onTap: () => {
          Provider.of<ClienteProvider>(context, listen: false)
              .setClienteSelecionado(cliente),
          print('Cliente: ${cliente.descricao}'),
          Navigator.of(context).pushNamed(Rotas.CLIENTE_DETALHAMENTO),
        },
      ),
    );
  }
}
