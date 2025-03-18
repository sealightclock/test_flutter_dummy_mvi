import 'package:dio/dio.dart';

class MyStringBackendServerDioApi {
  static const String backendServerUrl = 'http://example.com';

  final Dio _dio = Dio();

  Future<String> fetchContent() async {
    try {
      final response = await _dio.get(backendServerUrl);
      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        throw Exception('Failed to fetch content: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching content: $e');
    }
  }
}
