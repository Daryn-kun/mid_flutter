import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(new CalculatorApp());

class CalculatorApp extends StatelessWidget {
  Widget build(BuildContext buildcx) {
    return new MaterialApp(
      title: '',
      home: new Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String text = '0';
  String result = '0';
  String operation = '';
 // Calculation function starts ------------------------------------------------
  void calculation(btnText) {
    setState(() {
      if (btnText == 'C') {
        // clearing result and text if C clicked
        text = '0';
        result = '0';
      } else if (btnText == '=' && btnText != '%' && btnText != '+/-') {
        operation = text;
        operation = operation.replaceAll('×', '*');
        operation = operation.replaceAll('÷', '/');
        // calculating using math expressions
        // try catch block
        try {
          Parser p = Parser();
          Expression exp = p.parse(operation);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          // checking result for containing decimal numbers
          text = doesContainDecimal(result);
        } catch (e) {
          text = 'Error';
        }
      } else if (btnText == '%') {
        // if it's % clicked, we just find 10%
        dynamic to_double = double.parse(text) / 100;
        text = to_double.toString();
      } else if (btnText == '+/-') {
        // changing negative and positive numbers
        text.toString().startsWith('-')
            ? text = text.toString().substring(1)
            : text = '-' + text.toString();
      } else {
        // otherwise just write text
        // if it's zero, we are getting rid of it and just write number that user entered
        if (text == '0') {
          text = btnText;
        } else {
          text = text + btnText;
        }
      }
    });
  }
  // function for checking decimal numbers in result
  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  // Button widget
  Widget btn(dynamic btnText, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      color: color,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Color(0xFF3E3E3F), width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        onPressed: () {
          calculation(btnText);
        },
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget build(BuildContext buildCx) {
    return new Scaffold(
        appBar: null,
        backgroundColor: Color(0xFF3E3E3F),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 160, 10, 0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 60.0),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Table(
                    children: [
                      TableRow(children: [
                        btn('C', const Color(0xFF4E4F50)),
                        btn('+/-', const Color(0xFF4E4F50)),
                        btn('%', const Color(0xFF4E4F50)),
                        btn('÷', const Color(0xFFF3A23C)),
                      ]),
                      TableRow(children: [
                        btn('7', const Color(0xFF6C6C6C)),
                        btn('8', const Color(0xFF6C6C6C)),
                        btn('9', const Color(0xFF6C6C6C)),
                        btn('×', const Color(0xFFF3A23C)),
                      ]),
                      TableRow(children: [
                        btn('4', const Color(0xFF6C6C6C)),
                        btn('5', const Color(0xFF6C6C6C)),
                        btn('6', const Color(0xFF6C6C6C)),
                        btn('-', const Color(0xFFF3A23C)),
                      ]),
                      TableRow(children: [
                        btn('1', const Color(0xFF6C6C6C)),
                        btn('2', const Color(0xFF6C6C6C)),
                        btn('3', const Color(0xFF6C6C6C)),
                        btn('+', const Color(0xFFF3A23C)),
                      ]),
                      TableRow(children: [
                        btn('', const Color(0xFF6C6C6C)),
                        btn('0', const Color(0xFF6C6C6C)),
                        btn('.', const Color(0xFF6C6C6C)),
                        btn('=', const Color(0xFFF3A23C)),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
