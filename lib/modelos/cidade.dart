class Cidade {
  String uF, descricao;
  int id;

  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['id'] = obj['id'];
    map['uf'] = obj['uf'];
    map['descricao'] = obj['descricao'];
    return map;
  }
}
