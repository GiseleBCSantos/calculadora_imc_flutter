import 'package:flutter/material.dart';

// Função principal que inicializa o app Flutter
void main() {
  runApp(IMCCalculatorApp());
}

// Widget principal do aplicativo
class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // O MaterialApp define a estrutura básica do app, incluindo o tema e a tela inicial
    return MaterialApp(
      title: 'Calculadora de IMC', // Título do app
      theme: ThemeData(
        primarySwatch: Colors.purple, // Cor principal do tema
      ),
      home: IMCCalculator(), // Tela inicial do aplicativo
    );
  }
}

// Widget que define a tela da calculadora de IMC
class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

// Classe que gerencia o estado da tela da calculadora
class _IMCCalculatorState extends State<IMCCalculator> {
  // Controladores para capturar os valores digitados nos campos de texto
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  // String para armazenar o resultado do cálculo do IMC
  String _resultado = '';

  // Função que calcula o IMC com base no peso e altura fornecidos
  void _calcularIMC() {
    // Obtém os valores inseridos e tenta convertê-los para double
    final double? peso = double.tryParse(_pesoController.text);
    final double? altura = double.tryParse(_alturaController.text);

    // Verifica se os valores são válidos (não nulos e altura maior que 0)
    if (peso != null && altura != null && altura > 0) {
      setState(() {
        // Calcula o IMC: peso dividido pela altura ao quadrado
        double imc = peso / (altura * altura);

        // Armazena o valor do IMC formatado com 2 casas decimais
        _resultado = 'Seu IMC é: ${imc.toStringAsFixed(2)}\n';

        // Adiciona a interpretação (classificação) do valor do IMC
        _resultado += _interpretarIMC(imc);
      });
    } else {
      // Caso os valores sejam inválidos, exibe uma mensagem de erro
      setState(() {
        _resultado = 'Por favor, insira valores válidos.';
      });
    }
  }

  // Função que interpreta o valor do IMC e retorna uma explicação baseada na classificação
  String _interpretarIMC(double imc) {
    if (imc < 18.5) {
      return 'Você está abaixo do peso ideal.';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Você está no peso ideal.';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Você está com sobrepeso.';
    } else if (imc >= 30 && imc < 34.9) {
      return 'Você está com obesidade grau 1.';
    } else if (imc >= 35 && imc < 39.9) {
      return 'Você está com obesidade grau 2.';
    } else {
      return 'Você está com obesidade grau 3 (obesidade mórbida).';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar é a barra superior que exibe o título do app
      appBar: AppBar(
        title: Text('Calculadora de IMC', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple, // Cor de fundo da barra superior
        centerTitle: true, // Centraliza o título
      ),
      // Stack permite sobreposição de widgets
      body: Stack(
        children: [
          // Container para o plano de fundo com gradiente
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple[200]!, Colors.purple[600]!],
              ),
            ),
          ),
          // Ícones decorativos de fundo
          Positioned(
            top: 50,
            left: 30,
            child: Icon(
              Icons.fitness_center,
              size: 150,
              color: Colors.purple[100]!.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 30,
            child: Icon(
              Icons.health_and_safety,
              size: 150,
              color: Colors.purple[100]!.withOpacity(0.2),
            ),
          ),
          // Centraliza os campos de entrada e o botão
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
              children: <Widget>[
                // Título da seção de inserção de dados
                Text(
                  'Insira seus dados',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40), // Espaço entre os elementos

                // Campo de entrada para o peso
                SizedBox(
                  width: 300,  // Define a largura máxima do campo
                  child: TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number, // Teclado numérico
                    decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.white), // Cor do texto do rótulo
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2), // Cor de fundo dos campos de entrada
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: Icon(Icons.monitor_weight, color: Colors.white), // Ícone à esquerda
                    ),
                    style: TextStyle(color: Colors.white), // Cor do texto inserido
                    textAlign: TextAlign.center,  // Centraliza o texto digitado
                  ),
                ),

                SizedBox(height: 20), // Espaço entre os campos de entrada

                // Campo de entrada para a altura
                SizedBox(
                  width: 300,  // Define a largura máxima do campo
                  child: TextField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number, // Teclado numérico
                    decoration: InputDecoration(
                      labelText: 'Altura (m)',
                      labelStyle: TextStyle(color: Colors.white), // Cor do texto do rótulo
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2), // Cor de fundo dos campos de entrada
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: Icon(Icons.height, color: Colors.white), // Ícone à esquerda
                    ),
                    style: TextStyle(color: Colors.white), // Cor do texto inserido
                    textAlign: TextAlign.center,  // Centraliza o texto digitado
                  ),
                ),

                SizedBox(height: 30), // Espaço antes do botão

                // Botão para calcular o IMC
                SizedBox(
                  width: 300,  // Botão com largura limitada
                  child: ElevatedButton(
                    onPressed: _calcularIMC, // Chama a função de cálculo quando o botão é pressionado
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Calcular IMC',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30), // Espaço entre o botão e o resultado

                // Exibe o resultado do cálculo do IMC
                Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center, // Centraliza o texto do resultado
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
