import 'package:flutter_app_svm/modelos/condicao_pagamento.dart';
import 'package:flutter_app_svm/modelos/operacao_transacao.dart';

class LimiteCredito {
  String dataMaiorCompra, dataPrimeiraCompra, dataUltimaCompra;
  double creditoUtilizado,
      limiteCredito,
      saldoDisponivel,
      saldoDisponivelMenosPendentesBloqueados,
      valorMaiorCompra,
      valorMedioCompras,
      valorPedidosAFaturar,
      valorPedidosPendentesBloqueados,
      valorPrimeiraCompra,
      valorTotalCompras,
      valorUltimaCompra;
  int diasEmAtraso;
  List<CondicaoPagamento> condicoesPagamento;
  List<OperacaoTransacao> operacoesTransacao;

  LimiteCredito.fromJson(dynamic obj) {
    this.dataMaiorCompra = obj['dataMaiorCompra'];
    this.dataPrimeiraCompra = obj['dataPrimeiraCompra'];
    this.dataUltimaCompra = obj['dataUltimaCompra'];
    this.creditoUtilizado = obj['creditoUtilizado'];
    this.limiteCredito = obj['limiteCredito'];
    this.saldoDisponivel = obj['saldoDisponivel'];
    this.saldoDisponivelMenosPendentesBloqueados =
        obj['saldoDisponivelMenosPendentesBloqueados'];
    this.valorMaiorCompra = obj['valorMaiorCompra'];
    this.valorMedioCompras = obj['valorMedioCompras'];
    this.valorPedidosAFaturar = obj['valorPedidosAFaturar'];
    this.valorPedidosPendentesBloqueados =
        obj['valorPedidosPendentesBloqueados'];
    this.valorPrimeiraCompra = obj['valorPrimeiraCompra'];
    this.valorTotalCompras = obj['valorTotalCompras'];
    this.valorUltimaCompra = obj['valorUltimaCompra'];
    this.diasEmAtraso = obj['diasEmAtraso'];
  }
}
