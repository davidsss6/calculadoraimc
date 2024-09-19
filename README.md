# 🏋️ Calculadora de IMC

Este é um aplicativo desenvolvido em **Flutter** para calcular o **Índice de Massa Corporal (IMC)** dos usuários, permitindo que eles insiram sua altura e peso, e vejam o resultado de seu IMC com base nas informações fornecidas. O app também salva o histórico dos cálculos para consulta posterior, tudo de maneira simples e rápida!

## 📱 Tecnologias Utilizadas

- **Linguagem**: Dart com o framework Flutter.
- **Arquitetura**: Stateful Widgets para a interface e lógica de controle.
- **Persistência de dados**: Nesse projeto nao foi usado persistencia.

## 🚀 Funcionalidades

- **Cálculo do IMC**: Com base nos dados de altura e peso fornecidos.
- **Histórico de Cálculos**: Armazena o histórico dos IMCs calculados.
- **Validação de Campos**: Valida se os campos de altura e peso foram preenchidos corretamente.
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

### **Classe Principal do App: ImcPagState**

```dart
class ImcPagState extends StatefulWidget {
  const ImcPagState({super.key});

  @override
  State<ImcPagState> createState() => ImcPagStateState();
}
