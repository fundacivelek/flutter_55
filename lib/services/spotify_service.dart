import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/spotify_model.dart';

class SpotifyService {
  final String baseUrl = 'https://api.spotify.com/v1';
  final String clientId = dotenv.env['SPOTIFY_CLIENT_ID']!;
  final String clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET']!;

  Future<String> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<List<Song>> fetchTrendingSongs() async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('$baseUrl/browse/new-releases'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Song> songs = [];
      for (var item in data['albums']['items']) {
        songs.add(Song.fromJson(item));
      }
      return songs;
    } else {
      throw Exception('Failed to load trending songs');
    }
  }

  Future<Artist> fetchArtistDetails(String artistId) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('$baseUrl/artists/$artistId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Artist.fromJson(data);
    } else {
      throw Exception('Failed to load artist details');
    }
  }
}
