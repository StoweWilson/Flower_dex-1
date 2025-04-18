import 'package:flutter/material.dart';
import 'dart:typed_data';

class ResultPage extends StatelessWidget {
  final Uint8List image;
  final Map<String, dynamic> result;

  const ResultPage({super.key, required this.image, required this.result});

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
 
    if (flowerNames.containsKey(classLabel)) {
      return flowerNames[classLabel]!;
    }
 
    // If it's already a flower name from Gemini, just return it
    return classLabel;
  }

  String cleanMarkdown(String text) {
    return text
      .replaceAll(RegExp(r'[*_`#\-\\]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll('\n', ' ')
      .trim();
  }

  @override
  Widget build(BuildContext context) {
    print("🌼 DEBUG: result map = $result");
    print("🧠 AI Fact: ${result['facts']}");

    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.memory(image, height: 250),
              SizedBox(height: 20),
              Text(
                cleanMarkdown(getFlowerName(result['name']?.toString() ?? 'Unknown')),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text("Confidence: ${cleanMarkdown(result['confidence']?.toString() ?? '0')}%"),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Fact: ${cleanMarkdown(result['facts']?.toString() ?? 'No fact available.')}",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}