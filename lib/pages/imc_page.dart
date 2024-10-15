
import 'package:calculadoraimc/model/imc_hive_model.dart';
import 'package:calculadoraimc/repository/imcs_hive_repository.dart';
import 'package:calculadoraimc/service/calcula_imc.dart';
import 'package:calculadoraimc/service/configuracoes_sharedpreferences.dart';
import 'package:calculadoraimc/shared_widgets/resultado_dialog.dart';
import 'package:calculadoraimc/service/retorna_data.dart';
import 'package:calculadoraimc/shared_widgets/text_label.dart';
import 'package:calculadoraimc/shared_widgets/text_label_titulo.dart';
import 'package:calculadoraimc/service/valida_campos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImcPagState extends StatefulWidget {
  const ImcPagState({super.key});

  @override
  State<ImcPagState> createState() => ImcPagStateState();
}

class ImcPagStateState extends State<ImcPagState> {
  var pesoController = TextEditingController();
  Configuracoes configuracoes = Configuracoes();
  String nome = "";
  double altura = 0;


  late ImcsHiveRepository imcsRepository;
  var _imcs = const <ImcHiveModel>[];

  @override
  void initState() {
    super.initState();
    obterDadosUsuario();
  }

  void obterDadosUsuario() async  {
    imcsRepository = await ImcsHiveRepository.carregar();
    _imcs = imcsRepository.obterDados();
    nome = await configuracoes.getConfiguracoesNome();
    altura = await configuracoes.getConfiguracoesAltura();
    setState(() {});
    // _progressoUsuario = progressoUsuarioRepository.listar();
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
                  texto: "Entre com seu peso no campo abaixo:"),
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
                  onPressed: () async {
                    double cnfAltura = await configuracoes.getConfiguracoesAltura();
                    if (ValidaCampos.ValidarPeso(pesoController.text)) {
                        double imcDb = CalculaImc.calculaImcUsuario(cnfAltura.toString(), pesoController.text);
                        String resultado =
                            CalculaImc.resultadoImcUsuario(imcDb);
                        ResultadoDialog.mostrarAlertDialog(
                            this.context, resultado);
                        var imcSalvo = ImcHiveModel.criar(
                            int.parse(pesoController.text),
                            RetornaData.obterDataCorrente(),
                            imcDb);
                            imcsRepository.salvar(imcSalvo);
                      } else {
                        ResultadoDialog.mostrarAlertDialog(
                            this.context, ResultadoDialog.getMensagemErroCalculoImc());
                      }
                    _imcs = imcsRepository.obterDados();
                    setState(()  {
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

                itemCount: _imcs.length,
                itemBuilder: (BuildContext context, int index) {
                  var progressoUsuario = _imcs[index];
                  return ListTile(
                    title: Text("Resultado do seu IMC na data de: ${progressoUsuario.data}"),
                    subtitle: Text("Peso: ${progressoUsuario.peso.toString()} Seu IMC: ${progressoUsuario.imc.toString().substring(0, 2)}" ),
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
