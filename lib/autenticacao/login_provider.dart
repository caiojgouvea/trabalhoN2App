import 'package:flutter/material.dart';
import 'package:flutter_app_svm/modelos/empresa.dart';
import 'package:flutter_app_svm/produtos/produto_provider.dart';
import 'package:flutter_app_svm/sincronizacao/iniciar_database.dart';
import 'package:flutter_app_svm/sincronizacao/sincronizacao.dart';
import 'package:flutter_app_svm/sistema/sistema_dados.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

import '../sistema/api_resposta.dart';

enum AppState { inicial, autenticado, autenticando, desautenticado }

class LoginProvider extends ChangeNotifier {
  Usuario _usuario;
  AppState appState = AppState.inicial;
  Empresa _empresaLogada = new Empresa();

  Usuario getUsuarioLogado() {
    return _usuario;
  }

  void setUsuarioLogado(Usuario usuarioLogin) {
    this._usuario = usuarioLogin;
    notifyListeners();
  }

  void setEmpresaLogada(Empresa empresa) {
    this._empresaLogada = empresa;
    notifyListeners();
  }

  Empresa getEmpresaLogada() {
    return this._empresaLogada;
  }

  Future<ApiResposta> login(String usuario, String senha) async {
    try {
      appState = AppState.autenticando;
      final response = await http.post(
          Uri.parse('${SistemaDados.endPointAutenticacao}/login'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: 'inloc@kabeca00',
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'senha': senha,
              'usuario': usuario,
            },
          ));

      if (response.statusCode == 200) {
        ApiResposta apiResp = ApiResposta.map(json.decode(response.body));
        apiResp.logou = true;
        _atualizarUsuarioLogado(usuario, senha, apiResp);
        _usuario.empresas = await _getEmpresasDoUsuario();
        notifyListeners();
        return apiResp;
      } else {
        print(json.decode(response.body));
        ApiResposta apiResp = ApiResposta.map(json.decode(response.body));
        apiResp.logou = false;
        return apiResp;
      }
    } catch (e) {
      appState = AppState.desautenticado;
      ApiResposta apiResp = new ApiResposta();
      apiResp.mensagem = 'Falhar ao se conectar com o serviço de Login';
      apiResp.logou = false;
      notifyListeners();
      return apiResp;
    }
  }

  void _atualizarUsuarioLogado(
      String usuario, String senha, ApiResposta apiResp) {
    Usuario usuarioLogin = new Usuario();
    usuarioLogin.codgUsuario = usuario;
    usuarioLogin.senha = senha;
    usuarioLogin.token = apiResp.token;
    this._usuario = usuarioLogin;
  }

  Future<List<Empresa>> _getEmpresasDoUsuario() async {
    try {
      final String prefixo = 'Bearer ';
      final response = await http.get(
          Uri.parse('${SistemaDados.endPointAutenticacao}/usuarios/empresas'),
          headers: {
            HttpHeaders.authorizationHeader: prefixo + _usuario.token,
            'Content-type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        var empresasJson = json.decode(response.body) as List;
        List<Empresa> listaEmpresas =
            empresasJson.map((empresa) => Empresa.fromJson(empresa)).toList();
        return listaEmpresas;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> iniciarSincronizacao(
      Empresa empresa, BuildContext context) async {
    setEmpresaLogada(empresa);
    Provider.of<TabelaPrecoProvider>(context, listen: false).empresaLogada =
        empresa;
    IniciarDataBase inicializador = new IniciarDataBase();
    await inicializador.iniciarDataBase();
    if (inicializador.criouBanco) {
      SincronizacaoTabelas sincTabs = new SincronizacaoTabelas();
      await sincTabs.carregarTodasAsTabelas(this._usuario);
      print('caregou tabelas');
    } else {
      print('Nao carregou tabelas');
    }
  }
}
