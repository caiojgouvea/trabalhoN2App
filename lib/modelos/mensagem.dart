class Mensagem {
  int id;
  String data;
  String hora;
  String usuarioRemetente;
  String usuarioDestinatario;
  String titulo;
  String conteudo;
  String lida;

  Mensagem.fromJson(dynamic obj) {
    this.id = obj['id'];
    this.data = obj['data'];
    this.hora = obj['hora'];
    this.usuarioRemetente = obj['usuarioRemetente'];
    this.usuarioDestinatario = obj['usuarioDestinatario'];
    this.titulo = obj['titulo'];
    this.conteudo = obj['conteudo'];
    this.lida = obj['lida'];
  }
  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['id'] = obj['id'];
    map['data'] = obj['data'];
    map['hora'] = obj['hora'];
    map['usuarioRemetente'] = obj['usuarioRemetente'];
    map['usuarioDestinatario'] = obj['usuarioDestinatario'];
    map['titulo'] = obj['titulo'];
    map['conteudo'] = obj['conteudo'];
    map['lida'] = obj['lida'] == true ? '1' : '0';
    return map;
  }
}
