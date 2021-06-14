import 'dart:io';
import 'package:flutter_app_svm/modelos/mensagem.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:flutter_app_svm/sistema/sistema_dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MensagemDao {
  Future<void> _salvarMensagens(List<dynamic> mensagens) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      Batch batch = database.batch();
      int index = 0;
      while (index < mensagens.length) {
        batch.insert('mensagem', mensagens.elementAt(index),
            conflictAlgorithm: ConflictAlgorithm.replace);
        index++;
      }
      await batch.commit(noResult: true);
      print('Salvou Mensagem');
    } catch (e) {
      print(e);
    }
  }

  Future<List<Mensagem>> buscarMensagensNoBanco() async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      List<Map<String, dynamic>> listaRetorno =
          await database.query('mensagem');
      database.close();
      return List.generate(listaRetorno.length, (index) {
        return Mensagem.fromJson(listaRetorno.elementAt(index));
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> buscarMensagensNoServico(Usuario usuario) async {
    try {
      final String prefixo = 'Bearer ';
      final response = await http.get(
          Uri.parse('${SistemaDados.endPointComercial}/usuario/mensagens'),
          headers: {
            HttpHeaders.authorizationHeader: prefixo + usuario.token,
            'Content-type': 'application/json; charset=UTF-8',
            'CodgEmpresa': '001',
          });
      if (response.statusCode == 200) {
        var lista = json.decode(response.body) as List;
        await _salvarMensagens(
            lista.map((e) => Mensagem.fromJsonToMap(e)).toList());
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
  }
}
