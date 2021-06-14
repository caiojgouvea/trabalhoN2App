class Setor {
  String descricao;
  int id;

  static fromJsonToMap(dynamic obj) {
    Map<String, dynamic> map = new Map();
    map['id'] = obj['id'];
    map['descricao'] = obj['descricao'];
    return map;
  }
}
