import 'dart:io';
import 'package:flutter_app_svm/modelos/empresa.dart';
import 'package:flutter_app_svm/modelos/produto.dart';
import 'package:flutter_app_svm/modelos/tabela_preco.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:flutter_app_svm/sistema/sistema_dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TabelaPrecoDao {
  Future<List<Produto>> buscarProdutosNoBanco(TabelaPreco tabelaPreco) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      List<Map<String, dynamic>> listaRetorno = await database.query('produto',
          where: 'idTabelaPreco = ?', whereArgs: [tabelaPreco.idTabelaPreco]);
      List<Produto> listaProduto = List.generate(listaRetorno.length, (index) {
        return Produto.fromJson(listaRetorno.elementAt(index));
      });
      return listaProduto;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TabelaPreco> buscarTabelaPrecoNoBanco(Empresa empresa) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      List<Map<String, dynamic>> listaRetorno = await database.query(
          'tabela_preco',
          where: 'empresa = ?',
          whereArgs: [empresa.codgEmpresa]);
      TabelaPreco tab = new TabelaPreco();
      tab = List.generate(listaRetorno.length, (index) {
        return TabelaPreco.fromJson(listaRetorno[index]);
      }).elementAt(0);
      return tab;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _salvarProdutos(List<dynamic> produtos) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      Batch batch = database.batch();
      int index = 0;
      while (index < produtos.length) {
        batch.insert('produto', produtos.elementAt(index));
        index++;
      }
      await batch.commit(noResult: true);
      print('salvou produtos');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _salvarTabelaPreco(dynamic tabelaPreco) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      await database.insert('tabela_preco', tabelaPreco,
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('salvou tabela preco!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> buscarTabelaPrecoNoServico(Usuario usuario) async {
    try {
      final String prefixo = 'Bearer ';
      final response = await http.get(
          Uri.parse('${SistemaDados.endPointComercial}/empresa/tabelaPreco'),
          headers: {
            HttpHeaders.authorizationHeader: prefixo + usuario.token,
            'Content-type': 'application/json; charset=UTF-8',
            'CodgEmpresa': '001',
          });
      if (response.statusCode == 200) {
        var tabelaPreco = json.decode(response.body);
        // var listaProdutos = json.decode(response.body)['itens'] as List;
        var lista = (tabelaPreco['itens'] as List)
            .map((e) => Produto.fromJsonToMap(e))
            .toList();
        await _salvarTabelaPreco(TabelaPreco.fromJsonToMap(tabelaPreco));
        await _salvarProdutos(lista);
      }
    } catch (e) {
      return null;
    }
  }
}
