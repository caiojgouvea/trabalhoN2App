import 'package:flutter_app_svm/modelos/produto.dart';

class TabelaPreco {
  int id, codigo;
  String idTabelaPreco,
      descricao,
      validadeInicial,
      validadeFinal,
      empresa,
      embutirImposto;
  List<Produto> sermas;

  TabelaPreco();

  TabelaPreco.fromJson(dynamic obj) {
    this.id = obj['id'];
    this.idTabelaPreco = obj['idTabelaPreco'];
    this.codigo = obj['codigo'];
    this.empresa = obj['empresa'];
    this.descricao = obj['descricao'];
    this.validadeFinal = obj['validadeFinal'];
    this.validadeInicial = obj['validadeInicial'];
    this.embutirImposto = obj['embutirImposto'];
    // var jsonItens = obj['itens'] as List;
    // this.sermas = jsonItens.map((e) => Produto.fromJson(e))?.toList();
  }

  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['id'] = obj['id'];
    map['idTabelaPreco'] = obj['id'];
    map['codigo'] = obj['codigo'];
    map['empresa'] = obj['empresa'];
    map['descricao'] = obj['descricao'];
    map['validadeFinal'] = obj['validadeFinal'];
    map['validadeInicial'] = obj['validadeInicial'];
    map['embutirImposto'] = obj['embutirImposto'] == true ? '1' : '0';
    return map;
  }
}
