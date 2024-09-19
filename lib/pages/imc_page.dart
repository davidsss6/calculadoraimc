import 'package:calculadoraimc/model/dados_usuario.dart';
import 'package:calculadoraimc/repository/progresso_usuario.dart';
import 'package:calculadoraimc/shared_widgets/calcula_imc.dart';
import 'package:calculadoraimc/shared_widgets/resultado_dialog.dart';
import 'package:calculadoraimc/shared_widgets/retorna_data.dart';
import 'package:calculadoraimc/shared_widgets/text_label.dart';
import 'package:calculadoraimc/shared_widgets/text_label_titulo.dart';
import 'package:calculadoraimc/shared_widgets/valida_campos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImcPagState extends StatefulWidget {
  const ImcPagState({super.key});

  @override
  State<ImcPagState> createState() => ImcPagStateState();
}

class ImcPagStateState extends State<ImcPagState> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var _progressoUsuario = const <DadosUsuario>[];
  var progressoUsuarioRepository = ProgressoUsuario();

  @override
  void initState() {
    super.initState();
    obterProgressoUsuario();
  }

  void obterProgressoUsuario() {
    _progressoUsuario = progressoUsuarioRepository.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Calculadora de IMC'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset("lib/images/imc_logo.png"),
              const SizedBox(height: 20),
              const TextLabelTitulo(texto: "Calculadora de IMC"),
              const TextLabel(
                  texto: "Entre com seu peso e altura nos campos abaixo:"),
              TextField(
                keyboardType: TextInputType.number, // Define o teclado numérico
                controller: alturaController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                    hintText: "Altura",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.height,
                      color: Color.fromARGB(255, 141, 79, 151),
                    )),
              ),
              TextField(
                keyboardType: TextInputType.number, // Define o teclado numérico
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly // Permite apenas dígitos
                ],
                controller: pesoController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                    hintText: "Peso",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.baby_changing_station,
                      color: Color.fromARGB(255, 141, 79, 151),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (ValidaCampos.Validar(
                          alturaController.text, pesoController.text)) {
                        double imcDb = CalculaImc.calculaImcUsuario(
                            alturaController.text, pesoController.text);
                        String resultado =
                            CalculaImc.resultadoImcUsuario(imcDb);
                        ResultadoDialog.mostrarAlertDialog(
                            this.context, resultado);
                        var imcSalvo = DadosUsuario(
                            alturaController.text,
                            pesoController.text,
                            RetornaData.obterDataCorrente(),
                            imcDb);
                        progressoUsuarioRepository.adicionar(imcSalvo);
                      } else {
                        ResultadoDialog.mostrarAlertDialog(
                            this.context, ResultadoDialog.getMensagemErro());
                      }
                    });
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 141, 79, 151)),
                  )),
              const TextLabel(texto: "Resultados:"),
              ListView.builder(
                shrinkWrap:
                    true, // Adicione isso para evitar problemas de scroll
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _progressoUsuario.length,
                itemBuilder: (BuildContext context, int index) {
                  var progressoUsuario = _progressoUsuario[index];
                  return ListTile(
                    title: Text("Resultado do seu IMC na data de: ${progressoUsuario.data}"),
                    subtitle: Text("Altura: ${progressoUsuario.altura.toString()} Peso: ${progressoUsuario.peso.toString()} Seu IMC: ${progressoUsuario.imc.toString().substring(0, 2)}" ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
