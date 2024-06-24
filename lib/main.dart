import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = "0";
  String _input = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;
  bool _isOperatorClicked = false;
  bool _isEqualClicked = false;

  void _buttonPressed(String value) {
    if (value == "C") {
      _clear();
    } else if (value == "=") {
      _calculate();
    } else if (_isNumeric(value) || value == ".") {
      _handleNumeric(value);
    } else {
      _handleOperator(value);
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      _input = "";
      _operator = "";
      _num1 = 0;
      _num2 = 0;
      _isOperatorClicked = false;
      _isEqualClicked = false;
    });
  }

  void _calculate() {
    if (_operator.isNotEmpty && _input.isNotEmpty) {
      _num2 = double.parse(_input);
      double result = 0;
      switch (_operator) {
        case "+":
          result = _num1 + _num2;
          break;
        case "-":
          result = _num1 - _num2;
          break;
        case "*":
          result = _num1 * _num2;
          break;
        case "/":
          result = _num1 / _num2;
          break;
      }
      setState(() {
        _output = result.toString();
        _input = "";
        _num1 = result;
        _operator = "";
        _isOperatorClicked = false;
        _isEqualClicked = true;
      });
    }
  }

  void _handleNumeric(String value) {
    setState(() {
      if (_isEqualClicked) {
        _output = "0";
        _input = "";
        _isEqualClicked = false;
      }
      if (_output == "0" && value != ".") {
        _output = value;
        _input = value;
      } else {
        _output += value;
        _input += value;
      }
    });
  }

  void _handleOperator(String value) {
    setState(() {
      if (_isOperatorClicked) {
        _operator = value;
        _input = "";
      } else {
        _num1 = double.parse(_output);
        _operator = value;
        _input = "";
        _isOperatorClicked = true;
      }
    });
  }

  bool _isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _buttonPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    _output,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _input.isEmpty ? "" : "$_num1 $_operator $_input",
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("C"),
                    _buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("="),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
