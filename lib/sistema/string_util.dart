class StringUtil {
  static String formatarCpfCnpj(String valor) {
    String retorno = '';
    if (valor.length <= 11) {
      retorno = valor.substring(0, 3) +
          '.' +
          valor.substring(3, 6) +
          '.' +
          valor.substring(6, 9) +
          '-' +
          valor.substring(9, 11);
    } else {
      retorno = valor.substring(0, 2) +
          '.' +
          valor.substring(2, 5) +
          '.' +
          valor.substring(5, 8) +
          '/' +
          valor.substring(8, 12) +
          '-' +
          valor.substring(12);
    }
    return retorno;
  }
}
