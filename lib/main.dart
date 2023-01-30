import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Calculator',
      //theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: (() {
          calculation(btntxt); //-----------
        }),
        child: Text(
          btntxt,
          style: TextStyle(fontSize: 25, color: txtcolor),
        ),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: btncolor,
            padding: EdgeInsets.all(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Center(child: Text("Simple Calculator")),
          backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(text, //<--------
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 75)),
                ),
                //Text('0',textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 80)),
              ],
            ),
            //),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button functions will be called where we will pass some arguments.
                calcbutton("AC", Colors.grey, Colors.black),
                calcbutton("+/-", Colors.grey, Colors.black),
                calcbutton("%", Colors.grey, Colors.black),
                calcbutton("/", Colors.amber.shade700, Colors.white),
              ],
            ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button functions will be called where we will pass some arguments.
                calcbutton("7", Colors.grey.shade800, Colors.white),
                calcbutton("8", Colors.grey.shade800, Colors.white),
                calcbutton("9", Colors.grey.shade800, Colors.white),
                calcbutton("x", Colors.amber.shade700, Colors.white),
              ],
            ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button functions will be called where we will pass some arguments.
                calcbutton("4", Colors.grey.shade800, Colors.white),
                calcbutton("5", Colors.grey.shade800, Colors.white),
                calcbutton("6", Colors.grey.shade800, Colors.white),
                calcbutton("-", Colors.amber.shade700, Colors.white),
              ],
            ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button functions will be called where we will pass some arguments.
                calcbutton("1", Colors.grey.shade800, Colors.white),
                calcbutton("2", Colors.grey.shade800, Colors.white),
                calcbutton("3", Colors.grey.shade800, Colors.white),
                calcbutton("+", Colors.amber.shade700, Colors.white),
              ],
            ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // This is for button zero
                ElevatedButton(
                  onPressed: (() {
                    //button function
                    //calculation(btntxt);
                    //calcbutton("0", Colors.grey.shade800, Colors.white);
                  }),
                  child: calcbutton("0", Colors.grey.shade800, Colors.white),//Text("0",
                  //     style: TextStyle(fontSize: 25, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.fromLTRB(5, 0.5, 45, 5),
                      backgroundColor: Colors.grey.shade800),
                ),
                //calcbutton("0", Colors.grey.shade800, Colors.white),
                calcbutton(".", Colors.grey.shade800, Colors.white),
                calcbutton("=", Colors.amber.shade700, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0'; //<-----------
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
