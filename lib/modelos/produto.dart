class Produto {
  String idSerma, idApp, empresa, descricao, unidade, idTabelaPreco;
  int codigo;
  double decrescInicialPerm,
      decrescFinalPerm,
      acresInicialPerm,
      acresFinalPerm,
      qtdeEstoque,
      valor;
  List<int> idClassificacoesFiscais;

  Produto.fromJson(dynamic obj) {
    this.idSerma = obj['idSerma'];
    this.idTabelaPreco = obj['idTabelaPreco'];
    this.codigo = obj['codigo'];
    this.empresa = obj['empresa'];
    this.descricao = obj['descricao'];
    this.unidade = obj['unidade'];
    this.decrescInicialPerm = obj['decrescimoInicialPermitido'];
    this.decrescFinalPerm = obj['decrescimoFinalPermitido'];
    this.acresInicialPerm = obj['acrescimoInicialPermitido'];
    this.acresFinalPerm = obj['acrescimoFinalPermitido'];
    this.qtdeEstoque = double.parse(obj['quantidadeEstoque'].toString());
    this.idClassificacoesFiscais = obj['idClassificacoesFiscais'] != null
        ? new List<int>.from(obj['idClassificacoesFiscais'])
        : null;
    this.valor = double.parse(obj['valor'].toString());
  }

  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['idSerma'] = obj['idSerma'];
    map['idTabelaPreco'] = obj['idTabelaPreco'];
    map['codigo'] = obj['codigo'];
    map['empresa'] = obj['empresa'];
    map['descricao'] = obj['descricao'];
    map['unidade'] = obj['unidade'];
    map['decrescimoInicialPermitido'] = obj['decrescimoInicialPermitido'];
    map['decrescimoFinalPermitido'] = obj['decrescimoFinalPermitido'];
    map['acrescimoInicialPermitido'] = obj['acrescimoInicialPermitido'];
    map['acrescimoFinalPermitido'] = obj['acrescimoFinalPermitido'];
    map['quantidadeEstoque'] =
        double.parse(obj['quantidadeEstoque'].toString());
    // map[''] = obj['idClassificacoesFiscais'] != null
    //     ? new List<int>.from(obj['idClassificacoesFiscais'])
    //     : null;
    map['valor'] = double.parse(obj['valor'].toString());
    return map;
  }
}
