import 'package:calculadoraimc/model/dados_usuario.dart';

class ProgressoUsuario {

  final List<DadosUsuario> _dados = [];


  void adicionar(DadosUsuario dados) {
    _dados.add(dados);
  }

  List<DadosUsuario> listar() {
    return _dados;
  }



}