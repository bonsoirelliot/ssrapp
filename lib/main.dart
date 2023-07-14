import 'package:flutter/material.dart';
import 'package:ssrapp/presentation/home_screen.dart';

void main() {
  runApp(const EvalExample());
}

class EvalExample extends StatelessWidget {
  const EvalExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
