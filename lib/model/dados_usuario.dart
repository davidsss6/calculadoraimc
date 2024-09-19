
class DadosUsuario {

String altura;
String peso;
String data;
double imc;

DadosUsuario(this.altura, this.peso, this.data, this.imc);

static double calculaImcUsuario(String alturaStr, String pesoStr){
  double alturaDb = double.parse(alturaStr);
  double pestoDb = double.parse(pesoStr);

   if (alturaDb <= 0) {
      throw ArgumentError('A altura deve ser maior que zero.');
    }
    if (pestoDb <= 0) {
      throw ArgumentError('O peso deve ser maior que zero.');
    }
    return pestoDb / (alturaDb * alturaDb);
  }


}

