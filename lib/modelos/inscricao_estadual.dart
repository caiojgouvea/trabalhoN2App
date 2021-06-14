class InscricaoEstadual {
  String numero, tipoOperacao;
  bool programaIncentivoFiscal, eConsumidor;

  InscricaoEstadual.fromJson(dynamic obj) {
    this.numero = obj['numero'];
    this.tipoOperacao = obj['tipoOperacao'];
    this.programaIncentivoFiscal = obj['programaIncentivoFiscal'];
    this.eConsumidor = obj['eConsumidor'];
  }
}
