import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FlowerIdentifier {
  static Future<Map<String, String>> identifyFlower(Uint8List imageBytes) async {
    final uri = Uri.parse("http://localhost:8000/predict");

    print("🔁 Sending image to backend...");

    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile.fromBytes(
        'file', // must match FastAPI's field name
        imageBytes,
        filename: 'flower.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 Status: ${response.statusCode}");
      print("📥 Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final name = (decoded['name'] ?? 'Unknown').toString();
        final confidence = (decoded['confidence'] ?? '0').toString();
        return {
          'name': name,
          'confidence': confidence,
        };
      } else {
        return <String, String>{
          'name': 'Unknown',
          'confidence': '0',
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return <String, String>{
        'name': 'Unknown',
        'confidence': '0',
      };
    }
  }
}