import 'package:flutter/material.dart';
import 'package:flutter_app_svm/autenticacao/empresa_login.dart';
import 'package:flutter_app_svm/autenticacao/login_provider.dart';
import 'package:flutter_app_svm/autenticacao/pagina_login.dart';
import 'package:flutter_app_svm/clientes/cliente_detalhado.dart';
import 'package:flutter_app_svm/clientes/cliente_listagem.dart';
import 'package:flutter_app_svm/clientes/cliente_provider.dart';
import 'package:flutter_app_svm/mensagens/mensagem_listagem.dart';
import 'package:flutter_app_svm/mensagens/mensagem_provider.dart';
import 'package:flutter_app_svm/menuInicial/menu_inicial.dart';
import 'package:flutter_app_svm/produtos/produto_listagem.dart';
import 'package:flutter_app_svm/produtos/produto_provider.dart';
import 'package:flutter_app_svm/roteamento/rotas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: TabelaPrecoProvider()),
        ChangeNotifierProvider.value(value: MensagemProvider()),
        ChangeNotifierProvider.value(value: ClienteProvider()),
      ],
      child: MaterialApp(
        title: 'SVM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          Rotas.HOME: (_) => PaginaLogin(),
          Rotas.PAGINA_LOGIN: (_) => PaginaLogin(),
          Rotas.PAGINA_EMPRESA: (_) => EmpresaLogin(),
          Rotas.MENU_INICIAL: (_) => MenuInicial(),
          Rotas.PRODUTO_LISTAGEM: (_) => ProdutosListagem(),
          Rotas.MENSAGEM_LISTAGEM: (_) => MensagemListagem(),
          Rotas.CLIENTE_LISTAGEM: (_) => ClienteListagem(),
          Rotas.CLIENTE_DETALHAMENTO: (_) => ClienteDetalhamento(),
        },
      ),
    );
  }
}
