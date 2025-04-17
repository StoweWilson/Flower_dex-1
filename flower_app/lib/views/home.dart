import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../services/flower_identifier.dart';
import 'result_page.dart';
import 'dart:typed_data';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? imageBytes;

  void pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      setState(() {
        imageBytes = image;
      });

      try {
        final result = await FlowerIdentifier.identifyFlower("fake_path.jpg");

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(image: image, result: result),
          ),
        );
      } catch (e) {
        print('Error identifying flower: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to identify the flower.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffaf8ef),
      appBar: AppBar(title: Text("FlowerDex")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Upload a Flower", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Choose Photo"),
            ),
          ],
        ),
      ),
    );
  }
}