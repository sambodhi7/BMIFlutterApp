import 'dart:math';

import 'package:flutter/material.dart';

Color colorPrimary = Color.fromARGB(255, 45, 50, 80);

Color backgroundColor = Color.fromARGB(255, 66, 71, 105);
Color colorAccent = Color.fromARGB(255, 246, 177, 122);
Color colorSecondary = Color.fromARGB(255, 95, 101, 140); //// BMI CHART
///  Adults :
///   <16 severe thinness
///   16-17 moderate thinness
///  17-18.5 mild thinness
///  18.5-25 normal weight
///  25-30 Overweight
///  >30 Obese
///
///
///

List<String> bmiCategories = [
  'You have Severe thinness',
  'You have Moderate thinness',
  'You have mild thinness',
  'Congratulations You have a Healthy BMI ',
  'You are Overweight',
  'You are Obese',
];

List<List<int>> bmiGradientColorRanges = [
  [174, 118, 118],
  [239, 188, 155],
  [246, 177, 122],
  [118, 171, 174],
  [246, 177, 122],
  [174, 118, 118],
];

List<Color> bmiTextColor = [
  Color.fromARGB(255, 87, 40, 40),
  Color.fromARGB(255, 239, 188, 155),
  Color.fromARGB(255, 117, 74, 39),
  Color.fromARGB(255, 40, 84, 87),
  Color.fromARGB(255, 117, 74, 39),
  Color.fromARGB(255, 87, 40, 40),
];

Gradient getBmiGradient(double bmi) {
  int index = getBmiCategoryIndex(bmi);
  int r = bmiGradientColorRanges[index][0];
  int g = bmiGradientColorRanges[index][1];
  int b = bmiGradientColorRanges[index][2];
  return LinearGradient(
    colors: [
      Color.fromARGB(255, r, g, b),
      Color.fromARGB(130, r, g, b),
      Color.fromARGB(110, r, g, b),
      Color.fromARGB(68, r, g, b)
    ],
    transform: GradientRotation(7 * pi / 4),
    stops: [0, 0.5, 0.8, 1],
  );
}

int getBmiCategoryIndex(double bmi) {
  if (bmi < 16)
    return 0;
  else if (bmi >= 16 && bmi < 17)
    return 1;
  else if (bmi >= 17 && bmi < 18.5)
    return 2;
  else if (bmi >= 18.5 && bmi < 25)
    return 3;
  else if (bmi >= 25 && bmi < 30)
    return 4;
  else
    return 5;
}

class Bmipage extends StatelessWidget {
  final double bmi;
  final List<double> idealw;
  final bool weightinLbs;
  final double weight;

  const Bmipage(
      {super.key,
      required this.bmi,
      required this.idealw,
      required this.weightinLbs,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Your Bmi is")), body: body());
  }

  Widget body() {
    double w = this.weight;
    if (weightinLbs) {
      idealw[0] = idealw[0] * 2.20462;
      idealw[1] *= 2.20462;
      w = w * 2.20462;
    }

    String message;
    int i = getBmiCategoryIndex(bmi);
    if (i < 3)
      message =
          "You need to gain ${(idealw[0] - w).toStringAsFixed(0)} ${weightinLbs ? 'Lbs' : 'Kg'} ";
    else if (i > 3)
      message =
          'You need to loose ${(w - idealw[1]).toStringAsFixed(0)} ${weightinLbs ? 'Lbs' : 'Kg'} ';
    else
      message = "You have a perfect weight !";

    return SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                children: [
                  Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: getBmiGradient(bmi),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  bmi.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 70,
                                    color:
                                        bmiTextColor[getBmiCategoryIndex(bmi)],
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    bmiCategories[getBmiCategoryIndex(bmi)],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: bmiTextColor[
                                            getBmiCategoryIndex(bmi)]),
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          transform: GradientRotation(7 * pi / 4),
                          colors: [
                            colorPrimary,
                            backgroundColor,
                            colorSecondary,
                          ]),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(stops: [
                                0,
                                16 / 40,
                                17 / 40,
                                18.5 / 40,
                                25 / 40,
                                1
                              ], colors: [
                                ...bmiGradientColorRanges.map(
                                  (e) => Color.fromARGB(255, e[0], e[1], e[2]),
                                )
                              ])),
                        ),
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(stops: [
                                  0,
                                  min((bmi / 40) - 0.05, 0.98),
                                  min((bmi / 40), 1),
                                  min((bmi / 40) + 0.05, 0.9)
                                ], colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.blue,
                                  Colors.transparent,
                                ]))),
                        Positioned(left: 10, child: Text("Underweight")),
                        Positioned(right: 10, child: Text("Obese")),
                      ],
                    ),
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                                transform: GradientRotation(7 * pi / 4),
                                colors: [
                                  colorPrimary,
                                  backgroundColor,
                                  colorSecondary,
                                ]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Target Weight :",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${idealw[0].toStringAsFixed(0)}-${idealw[1].toStringAsFixed(0)} ${weightinLbs ? "Lbs" : "Kg"}',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ))),
                  Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
