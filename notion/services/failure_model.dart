import 'package:flutter_notion/failure_model.dart';
import 'dart:convert';
import 'dart:io';

class NotionService {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  NotionService({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Item>> getItems() async {
    try {
      final url =
          '${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2022-06-28',
        },
      );

      return _handleResponse(response);
    } catch (e) {
      throw Failure(message: 'An unexpected error occurred: $e');
    }
  }

  List<Item> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List).map((e) => Item.fromMap(e)).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
      case 400:
        throw Failure(message: 'Bad Request: ${response.body}');
      case 401:
        throw Failure(message: 'Unauthorized: ${response.body}');
      case 403:
        throw Failure(message: 'Forbidden: ${response.body}');
      case 404:
        throw Failure(message: 'Not Found: ${response.body}');
      case 500:
        throw Failure(message: 'Server Error: ${response.body}');
      default:
        throw Failure(message: 'Unexpected Error: ${response.body}');
    }
  }
}
