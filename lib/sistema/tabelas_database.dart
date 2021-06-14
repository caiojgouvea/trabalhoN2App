class Tabelas {
  static const String _create = 'CREATE TABLE';
  static const String tabelaMensagem =
      '$_create mensagem(id INTEGER PRIMARY KEY, data TEXT, hora TEXT, usuarioRemetente TEXT, ' +
          'usuarioDestinatario TEXT, titulo TEXT, conteudo TEXT, lida TEXT, empresa TEXT)';
  static const String tabelaPreco =
      '$_create tabela_preco(id INTEGER PRIMARY KEY, idTabelaPreco TEXT,' +
          'codigo INTEGER, empresa TEXT, descricao TEXT, validadeInicial TEXT, ' +
          'validadeFinal TEXT, embutirImposto TEXT)';
  static const String tabelaProduto =
      '$_create produto(idApp INTEGER PRIMARY KEY AUTOINCREMENT, ' +
          'idSerma TEXT, codigo INTEGER, idTabelaPreco TEXT, empresa TEXT, ' +
          'descricao TEXT, unidade TEXT, quantidadeEstoque REAL, ' +
          'idClassificacoesFiscais TEXT, decrescimoInicialPermitido REAL, ' +
          'decrescimoFinalPermitido REAL, acrescimoInicialPermitido REAL, ' +
          'acrescimoFinalPermitido REAL, valor REAL)';
  static const String tabelaCliente =
      '$_create cliente(idCliente INTEGER PRIMARY KEY, idSistema TEXT ' +
          'empresa TEXT, descricao TEXT, cpf TEXT, cnpj TEXT, ' +
          'codigo INTEGER, telefones TEXT, enderecoEntrega TEXT, ' +
          'inscricaoEstadual TEXT, limiteCredito TEXT, emails TEXT)';

  static const String tabelaCidade =
      '$_create cidade(id INTEGER PRIMARY KEY, uf TEXT, descricao TEXT)';

  static const String tabelaSetor =
      '$_create setor(id INTEGER PRIMARY KEY, descricao TEXT)';
}
