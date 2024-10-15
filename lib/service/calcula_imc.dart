
class CalculaImc {
  
  CalculaImc();

  static double calculaImcUsuario(String alturaStr, String pesoStr) {
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

  static String resultadoImcUsuario(double imc) {
    if (imc < 18.5) {
      return "Você está abaixo do peso.";
    } else if (imc >= 18.5 && imc < 24.9) {
      return "Você está com peso normal.";
    } else if (imc >= 25 && imc < 29.9) {
      return "Você está com sobrepeso.";
    } else {
      return "Você está obeso.";
    }
  }
}
