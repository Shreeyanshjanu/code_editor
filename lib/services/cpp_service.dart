import 'package:http/http.dart' as http;
import 'dart:convert';

class CppService {
  // Change this to your server URL (localhost for development)
  static const String baseUrl = 'http://localhost:8000';

  static Future<Map<String, dynamic>> compileAndRun({
    required String code,
    required String input,
    int timeout = 5,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/compile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': code,
          'input': input,
          'timeout': timeout,
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'output': '',
          'error': 'Server error: ${response.statusCode}',
          'execution_time': 0.0,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'output': '',
        'error': 'Network error: $e',
        'execution_time': 0.0,
      };
    }
  }
}
