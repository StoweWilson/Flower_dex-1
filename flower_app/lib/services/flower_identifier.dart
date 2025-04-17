import 'dart:math';

class FlowerIdentifier {
  static Future<Map<String, dynamic>> identifyFlower(String imagePath) async {
    // Fake AI logic
    List<String> flowers = ['Rose', 'Sunflower', 'Tulip', 'Daisy', 'Lily'];
    String picked = flowers[Random().nextInt(flowers.length)];
    int confidence = 75 + Random().nextInt(25); // 75-100%

    return {
      'name': picked,
      'confidence': confidence,
      'facts': '$picked is a beautiful flower known for its unique properties.'
    };
  }
}