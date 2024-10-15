
class RetornaData {

RetornaData();

static String obterDataCorrente () {

  var dataAgora = DateTime.now().toString();
  var dataFormatada = dataAgora.substring(0,16)+"hs";
  return dataFormatada;

}

}