import 'package:calculadoraimc/pages/imc_page.dart';
import 'package:calculadoraimc/service/configuracoes_sharedpreferences.dart';
import 'package:calculadoraimc/service/valida_campos.dart';
import 'package:calculadoraimc/shared_widgets/resultado_dialog.dart';
import 'package:calculadoraimc/shared_widgets/text_label.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  var nomeController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  Configuracoes configuracoes = Configuracoes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checarUsuarioJaEstaConfigurado();
  }

  void checarUsuarioJaEstaConfigurado () async {

    String nomeUsuarioConfigurado = await configuracoes.getConfiguracoesNome();
    if(!nomeUsuarioConfigurado.isEmpty){
      Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ImcPagState()));
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Calculadora de IMC'),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Image.asset("lib/images/imc_logo.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextLabel(texto: "Para começar a usar nosso app entre com seus dados abaixo:"),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: nomeController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                        hintText: "Seu nome",
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 141, 79, 151),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: alturaController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0),
                        enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 141, 79, 151))),
                        hintText: "Sua altura",
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.height,
                          color: Color.fromARGB(255, 141, 79, 151),
                        ),
                        ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () async {
                          if(ValidaCampos.ValidarNome(nomeController.text) && ValidaCampos.ValidarAltura(alturaController.text)){
                            await configuracoes.setConfiguracoesNome(nomeController.text);
                            await configuracoes.setConfiguracoesAltura(double.parse(alturaController.text));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ImcPagState()));
                          }else {
                            ResultadoDialog.mostrarAlertDialog(
                            this.context, ResultadoDialog.getMensagemErroCadastro());
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 79, 114, 151))),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}