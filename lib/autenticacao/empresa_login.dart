import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_svm/autenticacao/login_provider.dart';
import 'package:flutter_app_svm/modelos/empresa.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';
import 'package:flutter_app_svm/roteamento/rotas.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EmpresaLogin extends StatefulWidget {
  @override
  _EmpresaLoginState createState() => _EmpresaLoginState();
}

class _EmpresaLoginState extends State<EmpresaLogin> {
  Empresa _empresaSelecionada = new Empresa();
  Usuario usuario = new Usuario();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    usuario =
        Provider.of<LoginProvider>(context, listen: false).getUsuarioLogado();
    return Scaffold(
        appBar: AppBar(
          title: Text('INLOC SISTEMAS'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selecione a Empresa na qual deseja atuar'),
              comboBox(),
              _buildLoginBtn(context),
            ],
          ),
        ));
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 110,
      height: 60,
      child: RoundedLoadingButton(
        height: 40,
        elevation: 10,
        color: Colors.blue,
        valueColor: Colors.white,
        successColor: Colors.white,
        controller: _btnController,
        child: Text(
          'CONFIRMAR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () async {
          Timer(Duration(seconds: 1), () async {
            if (_empresaSelecionada != null &&
                _empresaSelecionada.codgEmpresa != null) {
              await Provider.of<LoginProvider>(context, listen: false)
                  .iniciarSincronizacao(_empresaSelecionada, context);
              _btnController.success();
              Navigator.pushReplacementNamed(context, Rotas.MENU_INICIAL);
            } else {
              _btnController.reset();
              ScaffoldMessenger.of(context).showSnackBar(_snackBarErro());
            }
          });
        },
      ),
    );
  }

  Widget _snackBarErro() {
    return SnackBar(
      content: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.error_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
          Text(
            'Nenhuma Empresa foi selecionada!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      elevation: 10,
    );
  }

  Widget comboBox() {
    return DropdownButton<String>(
      value: (_empresaSelecionada == null)
          ? _empresaSelecionada
          : _empresaSelecionada.codgEmpresa,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurple,
      ),
      onChanged: (String idSelecionado) {
        setState(() {
          _empresaSelecionada = usuario.empresas
              .firstWhere((element) => element.codgEmpresa == idSelecionado);
        });
      },
      items: usuario.empresas.map<DropdownMenuItem<String>>((Empresa empresa) {
        return DropdownMenuItem<String>(
            value: empresa.codgEmpresa, child: Text(empresa.descricaoEmpresa));
      }).toList(),
    );
  }
}
