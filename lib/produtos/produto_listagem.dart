import 'package:flutter/material.dart';
import 'package:flutter_app_svm/produtos/produto_provider.dart';
import 'package:flutter_app_svm/produtos/produto_tile.dart';
import 'package:provider/provider.dart';

class ProdutosListagem extends StatefulWidget {
  @override
  _ProdutosListagemState createState() => _ProdutosListagemState();
}

class _ProdutosListagemState extends State<ProdutosListagem> {
  int _itemQtde;
  TabelaPrecoProvider provider = new TabelaPrecoProvider();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TabelaPrecoProvider>(context);
    _itemQtde = provider.quantidadeDeProdutos;
    return Scaffold(
        appBar: AppBar(
          title: Text('PRODUTOS'),
        ),
        body: listaProdutos());
  }

  Widget listaProdutos() {
    return FutureBuilder(
        future: provider.getTabelaPreco(),
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
                ProdutoTile(provider.porIndex(index)),
          );
        });
  }
}
