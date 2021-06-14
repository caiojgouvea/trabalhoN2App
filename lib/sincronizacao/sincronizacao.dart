import 'package:flutter_app_svm/cidade/cidade_dao.dart';
import 'package:flutter_app_svm/clientes/cliente_dao.dart';
import 'package:flutter_app_svm/mensagens/mensagem_dao.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:flutter_app_svm/produtos/produto_dao.dart';
import 'package:flutter_app_svm/setor/setor_dao.dart';

class SincronizacaoTabelas {
  MensagemDao mensagemDao = new MensagemDao();
  TabelaPrecoDao tabelaPrecoDao = new TabelaPrecoDao();
  ClienteDao clienteDao = new ClienteDao();
  SetorDao setorDao = new SetorDao();
  CidadeDao cidadeDao = new CidadeDao();

  Future<void> carregarTodasAsTabelas(Usuario usuario) async {
    await carregarMensagems(usuario);
    await carregarTabelaPreco(usuario);
    await carregarClientes(usuario);
    await carregarCidades(usuario);
    await carregarSetores(usuario);
  }

  Future<void> carregarClientes(Usuario usuario) async {
    try {
      await clienteDao.buscarClientesNoServico(usuario);
    } catch (e) {
      print(e);
    }
  }

  Future<void> carregarMensagems(Usuario usuario) async {
    try {
      await mensagemDao.buscarMensagensNoServico(usuario);
    } catch (e) {
      print(e);
    }
  }

  Future<void> carregarTabelaPreco(Usuario usuario) async {
    try {
      await tabelaPrecoDao.buscarTabelaPrecoNoServico(usuario);
    } catch (e) {
      print(e);
    }
  }

  Future<void> carregarCidades(Usuario usuario) async {
    try {
      await cidadeDao.buscarCidadesNoServico(usuario);
    } catch (e) {
      print(e);
    }
  }

  Future<void> carregarSetores(Usuario usuario) async {
    try {
      await setorDao.buscarSetoresNoServico(usuario);
    } catch (e) {
      print(e);
    }
  }
}
