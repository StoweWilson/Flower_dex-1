import 'package:flutter/material.dart';
import 'dart:typed_data';

class ResultPage extends StatelessWidget {
  final Uint8List image;
  final Map<String, dynamic> result;

  ResultPage({required this.image, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.memory(image, height: 250),
            SizedBox(height: 20),
            Text(
              result['name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text("Confidence: ${result['confidence']}%"),
            SizedBox(height: 10),
            Text(result['facts']),
          ],
        ),
      ),
    );
  }
}