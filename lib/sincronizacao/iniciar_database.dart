import 'package:flutter_app_svm/sistema/tabelas_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class IniciarDataBase {
  Database dbApp;
  bool criouBanco = false;
  Future<void> iniciarDataBase() async {
    try {
      await openDatabase(
        join(await getDatabasesPath(), 'app_svm.db'),
        onCreate: (db, version) {
          db.execute(Tabelas.tabelaMensagem);
          print('criou tabela mensagem!');
          db.execute(Tabelas.tabelaPreco);
          print('criou tabela preco!');
          db.execute(Tabelas.tabelaProduto);
          print('criou tabela produto!');
          db.execute(Tabelas.tabelaCliente);
          print('criou tabela cliente!');
          db.execute(Tabelas.tabelaCidade);
          print('criou tabela cidade!');
          db.execute(Tabelas.tabelaSetor);
          print('criou tabela setor!');
          criouBanco = true;
        },
        onOpen: (_) => print('abriu conexao!'),
        version: 1,
      );

      // var dataBasesPath = await getDatabasesPath();
      // String path = join(dataBasesPath, 'app_svm.db');
      // await deleteDatabase(path);
      // print('exclui');
    } catch (e) {
      print(e);
    }
  }
}
