import 'package:flutter/material.dart';
import 'pages/homePage/home.dart';

void main() {
  runApp(const MyApp());
}

Color colorPrimary = Color.fromARGB(255, 45, 50, 80);
Color appBarColor = Color.fromARGB(255, 45, 50, 80);
Color backgroundColor = Color.fromARGB(255, 66, 71, 105);
Color colorAccent = Color.fromARGB(255, 246, 177, 122);
Color colorSecondary = Color.fromARGB(255, 95, 101, 140);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  foregroundColor: colorAccent, backgroundColor: colorPrimary),
            ),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                toolbarHeight: 80,
                backgroundColor: appBarColor,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                centerTitle: true),
            scaffoldBackgroundColor: backgroundColor,
            inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.grey),
                focusColor: colorAccent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorAccent, width: 2),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary, width: 5),
                ),
                fillColor: colorSecondary),
            useMaterial3: true,
            textTheme: TextTheme()),
        home: const HomePage());
  }
}
