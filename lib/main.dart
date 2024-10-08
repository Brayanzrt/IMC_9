import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//A classe home vai gerenciar o estado da nossa aplicação:
//A tela em execução e os valores dos campos
class Home extends StatefulWidget {
//Utilizamos o override para
//sobrescrever o comportamento de criação da nossa aplicação
  @override
  _HomeState createState() => _HomeState();
}

//Esta classe representa a nossa view
//ela extende o Estado da aplicação que criamos anteriormente
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _resultado = "Informe os seus dados";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _resultado = "Informe os seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text.replaceAll(',', '.'));
      double altura = double.parse(alturaController.text.replaceAll(',', '.'));

      double imc = peso / (altura * altura);
      _resultado = "seu imc é: ${imc.toStringAsPrecision(4)}";

      if (imc < 18.5) {
        _resultado += "(Abaixo do peso)";
      } else if (imc >= 18.5 && imc < 24.9) {
        _resultado += "(Peso normal)";
      } else if (imc >= 25 && imc < 29.9) {
        _resultado += "(Sobrepeso)";
      } else {
        _resultado += "(Obesidade)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.blue,
              ),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu peso!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira sua altura!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcularIMC();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
