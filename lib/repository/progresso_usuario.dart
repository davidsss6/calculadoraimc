import 'package:calculadoraimc/model/dados_consulta_imc.dart';


class ProgressoUsuario {

  final List<ConsultaImc> _dados = [];


  void adicionar(ConsultaImc dados) {
    _dados.add(dados);
  }

  List<ConsultaImc> listar() {
    return _dados;
  }



}