import 'package:flutter/material.dart';
import 'package:flutter_app_svm/modelos/produto.dart';

class ProdutoTile extends StatelessWidget {
  final Produto produto;
  const ProdutoTile(this.produto);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide()),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text(
          // '${produto.codigo} - ${produto.descricao}',
          '${produto.codigo} - ${produto.descricao}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            'Qtde Estoque:${produto.qtdeEstoque}, Preço: R\$${produto.valor}, Unidade: ${produto.unidade}',
            style: TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}
