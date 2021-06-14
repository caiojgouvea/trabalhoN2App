import 'package:flutter_app_svm/modelos/cliente.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'dart:io';
import 'package:flutter_app_svm/sistema/sistema_dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ClienteDao {
  Future<List<Cliente>> buscarClientesNoBanco() async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      List<Map<String, dynamic>> listaRetorno = await database.query('cliente');
      List<Cliente> listaClientes = List.generate(listaRetorno.length, (index) {
        return Cliente.fromJson(listaRetorno.elementAt(index));
      });
      return listaClientes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _salvarClientes(List<dynamic> clientes) async {
    try {
      final database =
          await openDatabase(join(await getDatabasesPath(), 'app_svm.db'));
      Batch batch = database.batch();
      int index = 0;
      while (index < clientes.length) {
        batch.insert('cliente', clientes.elementAt(index));
        index++;
      }
      await batch.commit(noResult: true);
      print('salvou clientes!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> buscarClientesNoServico(Usuario usuario) async {
    try {
      final String prefixo = 'Bearer ';
      String token =
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJJTkxPQyIsImlhdCI6MTYyMzY3NTgyOSwiZXhwIjoxNjI0NTM1ODI5fQ.oDYUJ5wBhQntAgPSnQyuqGCKB9YA8mt1rL4TCd6Y45YYowM-MM1sjcbOSab2EPD4VY1mes2VoL5TjGoNkFrkXw';
      final response = await http.get(
          Uri.parse('${SistemaDados.endPointComercial}/usuario/clientes'),
          headers: {
            HttpHeaders.authorizationHeader: prefixo + token,
            'Content-type': 'application/json; charset=UTF-8',
            'CodgEmpresa': '001',
          });
      if (response.statusCode == 200) {
        var lista = (json.decode(response.body) as List)
            .map((e) => Cliente.fromJsonToMap(e))
            .toList();
        await _salvarClientes(lista);
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
  }
}
