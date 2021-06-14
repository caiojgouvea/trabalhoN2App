class Empresa {
  String codgEmpresa;
  String descricaoEmpresa;

  Empresa();

  Empresa.fromJson(dynamic obj) {
    this.codgEmpresa = obj['id'];
    this.descricaoEmpresa = obj['descricao'];
  }
}
