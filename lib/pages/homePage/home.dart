import 'package:flutter/material.dart';
import '../bmiPage/bmiPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController feet = TextEditingController();
  TextEditingController inches = TextEditingController();

  bool heightUnitFeets = true;
  bool weightUnitLbs = false;

  List<double> getIdealWeightRange() {
    double h;
    if (heightUnitFeets) {
      h = double.parse(feet.text) * 12 + double.parse(inches.text);
      h = h * 0.0254;
    } else {
      h = double.parse(height.text);
      h = h / 100;
    }

    double lower = 18.5 * (h * h);
    double higher = 24.9 * (h * h);
    return [lower, higher];
  }

  double getWeight() {
    double w = double.parse(weight.text.toString());

    if (weightUnitLbs) {
      w = w * 0.454;
    }
    return w;
  }

  double getBMI() {
    double bmi;

    if (weight.text.isEmpty) return -1;
    double w = double.parse(weight.text.toString());

    if (weightUnitLbs) {
      w = w * 0.454;
    }
    double h = 1;
    if (heightUnitFeets) {
      h = double.parse(feet.text.toString()) * 12 +
          double.parse(inches.text.toString());
      h = h * 0.0254;
      if (feet.text.isEmpty || inches.text.isEmpty) return -1;
    } else {
      h = double.parse(height.text.toString());
      h = h / 100;
      if (height.text.isEmpty) return -1;
    }

    bmi = w / (h * h);
    return bmi;
  }

  Widget HeightEntryBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: (!heightUnitFeets)
            ? TextEnter("Height", height)
            : Row(
                children: [
                  Expanded(child: TextEnter("Feet", feet)),
                  Expanded(child: TextEnter("Inches", inches, t: 0, b: 0)),
                ],
              ),
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              //borderRadius: BorderRadius.zero, //Rectangular border
            ),
          ),
          onPressed: () => {
                setState(() {
                  heightUnitFeets = !heightUnitFeets;
                })
              },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
            child: Text(
              heightUnitFeets ? "Feet" : "Cm",
              style: TextStyle(fontSize: 20),
            ),
          ))
    ]);
  }

  Widget WeightEntryBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(child: TextEnter("Weight", weight)),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              //borderRadius: BorderRadius.zero, //Rectangular border
            ),
          ),
          onPressed: () => {
                setState(() {
                  weightUnitLbs = !weightUnitLbs;
                })
              },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
            child: Text(
              weightUnitLbs ? "Lbs" : "Kg",
              style: TextStyle(fontSize: 20),
            ),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: body());
  }

  Widget TextEnter(String text, TextEditingController controller,
      {double t = 10, double b = 10}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: text,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(b),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(t),
                    topRight: Radius.circular(0)),
              ),
            ),
            textAlignVertical: TextAlignVertical.top,
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "BMI",
              style: TextStyle(
                color: colorAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("APP"),
          )
        ],
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      centerTitle: true,
    );
  }

  Widget body() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 40, color: colorAccent),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Center(
                    child: Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text("Height : "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: HeightEntryBox(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text("Weight : "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: WeightEntryBox(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: ElevatedButton(
                                      onPressed: () => {
                                            if (this.getBMI() != -1)
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Bmipage(
                                                            bmi: this.getBMI(),
                                                            idealw:
                                                                getIdealWeightRange(),
                                                            weightinLbs:
                                                                weightUnitLbs,
                                                            weight: this
                                                                .getWeight(),
                                                          )))
                                          },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "CALCULATE",
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
