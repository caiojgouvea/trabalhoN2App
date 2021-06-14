import 'package:flutter/material.dart';
import 'package:flutter_app_svm/mensagens/mensagem_provider.dart';
import 'package:flutter_app_svm/mensagens/mensagem_tile.dart';
import 'package:provider/provider.dart';

class MensagemListagem extends StatefulWidget {
  @override
  _MensagemListagemState createState() => _MensagemListagemState();
}

class _MensagemListagemState extends State<MensagemListagem> {
  MensagemProvider provider = new MensagemProvider();
  int _itemQtde;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    _itemQtde = provider.quantidadeDeProdutos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: listaMensagens(),
    );
  }

  Widget listaMensagens() {
    return FutureBuilder(
      future: provider.getMensagens(),
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
              MensagemTile(provider.porIndex(index)),
        );
      },
    );
  }
}
