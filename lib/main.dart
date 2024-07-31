import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Operaciones Aritméticas'),
          backgroundColor: Colors.blue,
        ),
        body: const CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = "";
  String _operation = "Suma";

  void _calculate() {
    final num1 = double.tryParse(_num1Controller.text);
    final num2 = double.tryParse(_num2Controller.text);

    if (num1 != null && num2 != null) {
      double result;
      switch (_operation) {
        case 'Suma':
          result = num1 + num2;
          break;
        case 'Resta':
          result = num1 - num2;
          break;
        case 'Multiplicacion':
          result = num1 * num2;
          break;
        case 'Division':
          result = num2 != 0 ? num1 / num2 : double.infinity;
          break;
        default:
          result = 0;
          break;
      }

      setState(() {
        _result = result.isFinite ? result.toString() : 'Error';
      });
    } else {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _num1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Primer Valor',
              hintText: 'Ingrese un número',
            ),
          ),
          const SizedBox(height: 10),
          const Text('Valor Correcto'),
          const SizedBox(height: 20),
          TextField(
            controller: _num2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Segundo Valor',
              hintText: 'Ingrese un número',
            ),
          ),
          const SizedBox(height: 10),
          const Text('Valor Correcto'),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: _operation,
            onChanged: (String? newValue) {
              setState(() {
                _operation = newValue!;
              });
            },
            items: <String>['Suma', 'Resta', 'Multiplicacion', 'Division']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculate,
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 20),
          Text(
            'Resultado: $_result',
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
