import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_svm/modelos/empresa.dart';
import 'package:flutter_app_svm/modelos/produto.dart';
import 'package:flutter_app_svm/modelos/tabela_preco.dart';
import 'package:flutter_app_svm/produtos/produto_dao.dart';

class TabelaPrecoProvider extends ChangeNotifier {
  TabelaPreco _tabelaPreco = new TabelaPreco();
  TabelaPrecoDao tabelaPrecoDao = new TabelaPrecoDao();
  Empresa empresaLogada = new Empresa();

  Future<TabelaPreco> getTabelaPreco() async {
    if (_tabelaPreco.sermas == null) {
      await _inicializatabelaPreco();
    }
    return _tabelaPreco;
  }

  Future<void> _inicializatabelaPreco() async {
    this._tabelaPreco =
        await tabelaPrecoDao.buscarTabelaPrecoNoBanco(empresaLogada);
    this._tabelaPreco.sermas =
        await tabelaPrecoDao.buscarProdutosNoBanco(this._tabelaPreco);
    notifyListeners();
  }

  Produto porIndex(int i) {
    return _tabelaPreco.sermas != null
        ? _tabelaPreco.sermas.elementAt(i)
        : null;
  }

  int get quantidadeDeProdutos {
    return _tabelaPreco.sermas != null ? _tabelaPreco.sermas.length : 0;
  }

  void setTabelaPreco(TabelaPreco tabela) {
    this._tabelaPreco = tabela;
    notifyListeners();
  }
}
