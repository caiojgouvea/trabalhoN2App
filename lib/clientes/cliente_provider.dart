import 'package:flutter/cupertino.dart';
import 'package:flutter_app_svm/clientes/cliente_dao.dart';
import 'package:flutter_app_svm/modelos/cliente.dart';
import 'package:flutter_app_svm/modelos/usuario.dart';

class ClienteProvider extends ChangeNotifier {
  List<Cliente> _listaClientes;
  ClienteDao clienteDao = new ClienteDao();
  Cliente clienteSelecionado = new Cliente();

  Future<List<Cliente>> getListaClientes(Usuario usuario) async {
    if (_listaClientes == null) {
      this._listaClientes = await clienteDao.buscarClientesNoBanco();
      notifyListeners();
    }
//    this._listaClientes = await clienteDao.buscarClientesNoBanco();
//    notifyListeners();
    return this._listaClientes;
  }

  void setClienteSelecionado(Cliente cliente) {
    this.clienteSelecionado = cliente;
    notifyListeners();
  }

  set setListaClientes(List<Cliente> lista) {
    this._listaClientes = lista;
  }

  int get quantidadeClientes {
    return _listaClientes == null ? 0 : _listaClientes.length;
  }

  Cliente porIndex(int i) {
    return _listaClientes != null ? _listaClientes.elementAt(i) : null;
  }
}
