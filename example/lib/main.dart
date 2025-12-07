import 'package:flutter/material.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
  children: [
    Positioned.fill(
      child: PaintBoxView(), // Kotlin View
    ),
    Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(onPressed: () {}, child: Text("ONPRESS")),     // Flutter widget
    ),
  ],
)
      ),
    );
  }
}
