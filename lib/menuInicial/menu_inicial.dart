import 'package:flutter/material.dart';
import 'package:flutter_app_svm/roteamento/rotas.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenuInicial extends StatefulWidget {
  @override
  _MenuInicialState createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blueGrey[100],
              Colors.blueGrey[50],
              Colors.blueGrey[100],
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
          child: StaggeredGridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            staggeredTiles: _staggeredTiles,
            children: _tiles,
          ),
        ),
      ),
    );
  }
}

const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(3, 1),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
];

const List<Widget> _tiles = <Widget>[
  _ItemMenuTile(Icons.person, 'Clientes', Rotas.CLIENTE_LISTAGEM),
  _ItemMenuTile(Icons.shopping_cart, 'Produtos', Rotas.PRODUTO_LISTAGEM),
  _ItemMenuTile(Icons.widgets_outlined, 'Pedidos', Rotas.HOME),
  _ItemMenuTile(Icons.access_alarm, 'Teste', Rotas.MENU_INICIAL),
  _ItemMenuTile((true) ? Icons.message_outlined : Icons.message_rounded,
      'Mensagens', Rotas.MENSAGEM_LISTAGEM),
  _ItemMenuTile(Icons.exit_to_app, 'Sair', Rotas.HOME)
];

class _ItemMenuTile extends StatelessWidget {
  const _ItemMenuTile(this.icone, this.titulo, this.caminho);

  final IconData icone;
  final String titulo;
  final String caminho;

  @override
  Widget build(BuildContext context) {
    // final value = Provider.of<LoginProvider>(context).getUsuarioLogado();

    return Card(
      color: Colors.blue,
      child: InkWell(
        onTap: () => {
          if (!(this.caminho == Rotas.HOME))
            {Navigator.of(context).pushNamed(this.caminho)}
          else
            {Navigator.pushReplacementNamed(context, this.caminho)}
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                this.icone,
                size: 50,
                color: Colors.white,
              ),
              Text(titulo,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
