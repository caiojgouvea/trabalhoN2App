import 'package:flutter_app_svm/modelos/empresa.dart';

class Usuario {
  String codgUsuario;
  String senha;
  String token;
  List<Empresa> empresas;

  Usuario();

  Usuario.map(dynamic obj, String senha) {
    this.codgUsuario = obj["usuario"];
    this.token = obj["token"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["usuario"] = codgUsuario;
    map["token"] = token;

    return map;
  }
}
