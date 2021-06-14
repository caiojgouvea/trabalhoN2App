import 'package:flutter/material.dart';
import 'package:flutter_app_svm/autenticacao/login_provider.dart';
import 'package:flutter_app_svm/clientes/cliente_provider.dart';
import 'package:flutter_app_svm/clientes/cliente_tile.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:provider/provider.dart';

class ClienteListagem extends StatefulWidget {
  @override
  _ClienteListagemState createState() => _ClienteListagemState();
}

class _ClienteListagemState extends State<ClienteListagem> {
  ClienteProvider provider = ClienteProvider();
  int _itemQtde;
  Usuario usuario = new Usuario();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    _itemQtde = provider.quantidadeClientes;
    usuario = Provider.of<LoginProvider>(context).getUsuarioLogado();

    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Clientes'),
      ),
      body: listaClientes(),
    );
  }

  Widget listaClientes() {
    return FutureBuilder(
      future: provider.getListaClientes(usuario),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container(
            child: CircularProgressIndicator(),
            color: Colors.black,
          );
        }
        return ListView.builder(
          itemCount: _itemQtde,
          itemBuilder: (context, index) =>
              ClienteTile(provider.porIndex(index)),
        );
      },
    );
  }
}
