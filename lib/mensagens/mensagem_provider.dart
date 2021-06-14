import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_svm/mensagens/mensagem_dao.dart';
import 'package:flutter_app_svm/modelos/mensagem.dart';

class MensagemProvider extends ChangeNotifier {
  List<Mensagem> _mensagens;
  MensagemDao mensagemDao = new MensagemDao();

  Future<List<Mensagem>> getMensagens() async {
    if (_mensagens == null) {
      this._mensagens = await mensagemDao.buscarMensagensNoBanco();
      notifyListeners();
    }
    return _mensagens;
  }

  Mensagem porIndex(int i) {
    return _mensagens != null ? _mensagens.elementAt(i) : null;
  }

  int get quantidadeDeProdutos {
    return _mensagens != null ? _mensagens.length : 0;
  }

  void setMensagens(List<Mensagem> lista) {
    this._mensagens = lista;
    notifyListeners();
  }
}
