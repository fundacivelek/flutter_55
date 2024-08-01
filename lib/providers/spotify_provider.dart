import 'package:flutter/material.dart';
import '../../services/spotify_service.dart';
import '../../models/spotify_model.dart';

class SpotifyProvider with ChangeNotifier {
  SpotifyService _spotifyService = SpotifyService();
  List<Song> trendingSongs = [];
  Artist? artist;

  SpotifyProvider() {
    fetchTrendingSongs();
  }

  Future<void> fetchTrendingSongs() async {
    trendingSongs = await _spotifyService.fetchTrendingSongs();
    notifyListeners();
  }

  Future<void> fetchArtistDetails(String artistId) async {
    artist = await _spotifyService.fetchArtistDetails(artistId);
    notifyListeners();
  }
}
