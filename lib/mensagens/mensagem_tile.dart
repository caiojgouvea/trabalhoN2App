import 'package:flutter/material.dart';
import 'package:flutter_app_svm/modelos/mensagem.dart';

class MensagemTile extends StatelessWidget {
  final Mensagem mensagem;
  const MensagemTile(this.mensagem);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide()),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text(
          'DE: LÚCIO',
          style: TextStyle(
              fontWeight:
                  mensagem.lida == '1' ? FontWeight.bold : FontWeight.normal),
        ),
        subtitle: Text('Em 25/05/2021 às 12:34.',
            style: TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}
