
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultadoDialog {


  ResultadoDialog();

  static String resultadoErro = "Voce precisa preencher todos os campos corretamente!\n\n Dicas:\n\n- Nao deixe nenhum campo em branco.\n- Na altura coloque ponto e nao vígula";
 
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

  static String getMensagemErro () {
    return resultadoErro;
  }

}