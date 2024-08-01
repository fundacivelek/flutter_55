import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/spotify_provider.dart';

class ArtistScreen extends StatelessWidget {
  final String artistId;

  ArtistScreen({required this.artistId});

  @override
  Widget build(BuildContext context) {
    final spotifyProvider = Provider.of<SpotifyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Artist Details'),
      ),
      body: FutureBuilder(
        future: spotifyProvider.fetchArtistDetails(artistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final artist = spotifyProvider.artist;
          return artist == null
              ? Center(child: Text('Artist not found'))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${artist.name}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Followers: ${artist.followers}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Popularity: ${artist.popularity}', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
