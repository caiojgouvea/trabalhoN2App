class ApiResposta {
  String mensagem;
  String token;
  bool logou;

  ApiResposta({this.mensagem, this.token});

  ApiResposta.map(dynamic obj) {
    this.mensagem = obj['message'];
    this.token = obj["token"];
  }
}
