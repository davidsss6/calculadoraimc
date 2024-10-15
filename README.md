# 🏋️ Calculadora de IMC

Este é um aplicativo desenvolvido em Flutter para calcular o Índice de Massa Corporal (IMC) dos usuários. Ele permite que os usuários insiram sua altura e peso, e vejam o resultado do IMC baseado nas informações fornecidas. O app também salva o histórico dos cálculos e mantém os dados do usuário de forma persistente, garantindo uma experiência contínua mesmo ao fechar o app!

## 📱 Tecnologias Utilizadas

- **Linguagem**: Dart com o framework Flutter.
- **Arquitetura**: Stateful Widgets para a interface e lógica de controle.
- **Persistência de dados**: Shared Preferences: Para salvar o nome e a altura do usuário. Hive: Para armazenar o histórico de todos os cálculos de IMC.


## 🚀 Funcionalidades

- **Cálculo do IMC**: Com base nos dados de altura e peso fornecidos.
- **Histórico de Cálculos**: Armazena o histórico dos IMCs calculados para consulta futura.
- **Validação de Campos**:  Verifica se os campos de altura e peso foram preenchidos corretamente antes do cálculo.
- **Persistência de Dados:**: Mantém o nome do usuário e sua altura gravados, mesmo após o fechamento do aplicativo.
- **Teclado Numérico**: Facilita a entrada de dados nos campos de texto.
- **Saída do App**: Um botão flutuante para sair do aplicativo.

---

## 🎨 Interface do Usuário

A interface do aplicativo foi feita com **Widgets** do Flutter, incluindo **TextField**, **ListView** e **FloatingActionButton**. 

---

### 🌟 Widgets Personalizados

- **TextFields** personalizados para inserir altura e peso.
- **AlertDialog** para exibir mensagens de erro ou o resultado do IMC.
- **ListView.builder** para mostrar o histórico dos cálculos de IMC realizados.

---

## 👩‍💻 Estrutura do Código

### **Classe Principal do App: CadastroPage e ImcPagState**

```dart
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
