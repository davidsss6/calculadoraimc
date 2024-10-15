
import 'package:flutter/material.dart';

class ResultadoDialog {


  ResultadoDialog();

  static String resultadoErroCadastro = "Voce precisa preencher todos os campos corretamente!\n\n Dicas:\n\n- Nao deixe nenhum campo em branco.\n- Na altura coloque ponto e nao vígula.";
  static String resultadoErroCalculoImc = "Voce precisa preencher o campo corretamente!\n\n Dicas:\n\n- Nao deixe o campo em branco. \n- No peso coloque um numero inteiro, sem ponto ou vírgula.";

  static void mostrarAlertDialog(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static String getMensagemErroCadastro () {
    return resultadoErroCadastro;
  }

  static String getMensagemErroCalculoImc () {
    return resultadoErroCalculoImc;
  }

}