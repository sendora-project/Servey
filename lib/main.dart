import 'package:flutter/material.dart';
import 'package:servey/pages/home.dart';

void main() {
  runApp(const Servey());
}

class Servey extends StatelessWidget {
  const Servey({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
