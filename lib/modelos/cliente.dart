import 'dart:convert';
import 'package:flutter_app_svm/modelos/endereco_entrega.dart';
import 'package:flutter_app_svm/modelos/inscricao_estadual.dart';
import 'package:flutter_app_svm/modelos/limite_credito.dart';
import 'package:flutter_app_svm/sistema/string_util.dart';

class Cliente {
  String idCliente, empresa, descricao, cpf, cnpj;
  int codigo;
  List<String> telefones;
  List<String> emails;
  EnderecoEntrega enderecoEntrega;
  InscricaoEstadual inscricaoEstadual;
  LimiteCredito limiteCredito;

  Cliente();

  String getCpfCnpj() {
    return cpf != null
        ? 'CPF: ${StringUtil.formatarCpfCnpj(this.cpf)}'
        : 'CNPJ: ${StringUtil.formatarCpfCnpj(this.cnpj)}';
  }

  Cliente.fromJson(dynamic obj) {
    this.idCliente = obj['idSistema'];
    this.codigo = obj['codigo'];
    this.descricao = obj['descricao'];
    this.emails =
        obj['emails'] != null ? obj['emails'].toString().split(',') : null;
    this.telefones = obj['telefones'] != null
        ? obj['telefones'].toString().split(',')
        : null;
    this.cpf = obj['cpf'];
    this.cnpj = obj['cnpj'];
    this.enderecoEntrega =
        EnderecoEntrega.fromJson(jsonDecode(obj['enderecoEntrega']));
    this.inscricaoEstadual =
        InscricaoEstadual.fromJson(jsonDecode(obj['inscricaoEstadual']));
    var limiteCredito = jsonDecode(obj['limiteCredito']);
    this.limiteCredito =
        limiteCredito != null ? LimiteCredito.fromJson(limiteCredito) : null;
  }

  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['idCliente'] = int.parse(obj['id']);
    map['idSistema'] = obj['idSistema'];
    map['codigo'] = obj['codigo'];
    map['descricao'] = obj['descricao'];
    map['emails'] =
        obj['emails'] != null ? (obj['emails'] as List).join(',') : null;
    map['telefones'] =
        obj['telefones'] != null ? (obj['telefones'] as List).join(',') : null;
    map['CPF'] = obj['CPF'];
    map['CNPJ'] = obj['CNPJ'];
    map['inscricaoEstadual'] = json.encode(obj['inscricaoEstadual']);
    map['enderecoEntrega'] = json.encode(obj['enderecoEntrega']);
    map['limiteCredito'] = json.encode(obj['limiteCredito']);
    return map;
  }
}
