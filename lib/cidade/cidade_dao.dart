import 'dart:io';
import 'package:flutter_app_svm/modelos/cidade.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:flutter_app_svm/sistema/sistema_dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CidadeDao {
  Future<void> _salvarCidades(List<dynamic> cidades) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      Batch batch = database.batch();
      int index = 0;
      while (index < cidades.length) {
        batch.insert('cidade', cidades.elementAt(index),
            conflictAlgorithm: ConflictAlgorithm.replace);
        index++;
      }
      await batch.commit(noResult: true);
      print('Salvou Cidades');
    } catch (e) {
      print(e);
    }
  }

  Future<void> buscarCidadesNoServico(Usuario usuario) async {
    try {
      final String prefixo = 'Bearer ';
      final response = await http.get(
          Uri.parse('${SistemaDados.endPointComercial}/cidades'),
          headers: {
            HttpHeaders.authorizationHeader: prefixo + usuario.token,
            'Content-type': 'application/json; charset=UTF-8',
            'CodgEmpresa': '001',
          });
      if (response.statusCode == 200) {
        var lista = json.decode(response.body) as List;
        await _salvarCidades(
            lista.map((e) => Cidade.fromJsonToMap(e)).toList());
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
  }
}
