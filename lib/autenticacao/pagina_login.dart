import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_svm/sistema/api_resposta.dart';
import 'package:flutter_app_svm/autenticacao/login_provider.dart';
import 'package:flutter_app_svm/autenticacao/estilo_login.dart';
import 'package:flutter_app_svm/roteamento/rotas.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  TextEditingController _usuario;
  TextEditingController _senha;
  ApiResposta _apiResp;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _usuario = TextEditingController(text: "");
    _senha = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[700],
                      Colors.blue,
                      Colors.blue[600],
                      Colors.blue[700],
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 150.0,
                ),
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: SizedBox(
                  width: 400,
                  height: 350,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 70.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        _buildUsuarioTF(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _buildSenhaTF(),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usuario.dispose();
    _senha.dispose();
    super.dispose();
  }

  Widget _buildUsuarioTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDecorationEstilo,
          height: 40.0,
          child: TextFormField(
            controller: _usuario,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.person_pin_sharp,
                color: Colors.black54,
              ),
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              hintText: 'Usuário',
              contentPadding: EdgeInsets.only(top: 10),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 130,
      height: 70,
      child: RoundedLoadingButton(
        height: 40,
        elevation: 10,
        color: Colors.blue,
        valueColor: Colors.white,
        successColor: Colors.white,
        controller: _btnController,
        child: Text(
          'LOGAR',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () async {
          Timer(Duration(seconds: 1), () async {
            _apiResp = await context
                .read<LoginProvider>()
                .login(_usuario.text, _senha.text);
            if (!_apiResp.logou) {
              ScaffoldMessenger.of(context).showSnackBar(
                _snackBarErro(),
              );
              _btnController.reset();
            } else {
              _btnController.success();
              Navigator.pushReplacementNamed(context, Rotas.PAGINA_EMPRESA);
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
            _apiResp.mensagem + '!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      elevation: 10,
    );
  }

  Widget _buildSenhaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDecorationEstilo,
          height: 40.0,
          child: TextFormField(
            controller: _senha,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black54,
              ),
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              contentPadding: EdgeInsets.only(top: 10),
              hintText: 'Senha',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
