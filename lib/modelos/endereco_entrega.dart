import 'package:flutter_app_svm/modelos/cidade.dart';
import 'package:flutter_app_svm/modelos/setor.dart';

class EnderecoEntrega {
  String logradouro, cep;
  Setor setor;
  Cidade cidade;

  EnderecoEntrega.fromJson(dynamic obj) {
    this.logradouro = obj['logradouro'];
    this.cep = obj['CEP'];
  }
}
