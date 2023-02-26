import 'package:calculator_app/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> buttonTextList = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '00',
    '0',
    '.',
    '=',
  ];

  String userQuestion = '';
  String userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade200,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: const TextStyle(
                          fontSize: 60,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttonTextList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                //clear button
                if (index == 0) {
                  return CalcButton(
                    ontap: () {
                      setState(() {
                        userQuestion = '';
                      });
                    },
                    buttonText: buttonTextList[index],
                    buttonColor: Colors.green,
                    textColor: Colors.white,
                  );
                }

                //delete button
                if (index == 1) {
                  return CalcButton(
                    ontap: () {
                      setState(() {
                        if (userQuestion.isNotEmpty) {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        }
                      });
                    },
                    buttonText: buttonTextList[index],
                    buttonColor: Colors.red,
                    textColor: Colors.white,
                  );
                }

                // answer button
                if (index == buttonTextList.length - 1) {
                  return CalcButton(
                      ontap: () {
                        calculate(userQuestion);
                      },
                      buttonText: buttonTextList[index],
                      buttonColor: isOperator(buttonTextList[index])
                          ? Colors.deepOrange
                          : Colors.deepOrange.shade50,
                      textColor: isOperator(buttonTextList[index])
                          ? Colors.white
                          : Colors.deepOrange);
                }

                //other buttons
                else {
                  return CalcButton(
                      ontap: () {
                        setState(() {
                          userQuestion += buttonTextList[index];
                        });
                      },
                      buttonText: buttonTextList[index],
                      buttonColor: isOperator(buttonTextList[index])
                          ? Colors.deepOrange
                          : Colors.deepOrange.shade50,
                      textColor: isOperator(buttonTextList[index])
                          ? Colors.white
                          : Colors.deepOrange);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String text) {
    if (text == '/' ||
        text == 'x' ||
        text == '+' ||
        text == '-' ||
        text == '=' ||
        text == '%') {
      return true;
    } else {
      return false;
    }
  }

  void calculate(String text) {
    String replacedtext = text.replaceAll('x', '*');
    Parser p = Parser();

    Expression exp = p.parse(replacedtext);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userAnswer = eval.toStringAsFixed(2);
    });
  }
}
