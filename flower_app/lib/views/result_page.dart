import 'package:flutter/material.dart';
import 'dart:typed_data';

class ResultPage extends StatelessWidget {
  final Uint8List image;
  final Map<String, dynamic> result;

  ResultPage({required this.image, required this.result});

  String getFlowerName(String classLabel) {
    const flowerNames = {
      'Class 0': 'Pink Primrose',
      'Class 1': 'Hard-leaved Pocket Orchid',
      'Class 2': 'Canterbury Bells',
      'Class 3': 'Sweet Pea',
      'Class 4': 'English Marigold',
      'Class 5': 'Tiger Lily',
      'Class 6': 'Moon Orchid',
      'Class 7': 'Bird of Paradise',
      'Class 8': 'Monkshood',
      'Class 9': 'Globe Thistle',
      // Add more mappings here as needed
    };
    return flowerNames[classLabel] ?? classLabel;
  }

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
              getFlowerName(result['name']?.toString() ?? 'Unknown'),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text("Confidence: ${result['confidence']?.toString() ?? '0'}%"),
            SizedBox(height: 10),
            Text(result['facts']?.toString() ?? 'No facts available.'),
          ],
        ),
      ),
    );
  }
}