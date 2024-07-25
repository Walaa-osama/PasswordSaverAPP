import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

ColorScheme light = ColorScheme.light(
  primary: Color.fromARGB(255, 6, 19, 190),
);

ColorScheme dark =
    ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.dark);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: light.primary),
        colorScheme: light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.red),
        cardTheme: CardTheme(color: Color.fromARGB(255, 123, 35, 28)),
        colorScheme: dark,
        textTheme: TextTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Password Saver'),
    );
  }
}
