import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/providers/spotify_provider.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spotifyProvider = Provider.of<SpotifyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Songs'),
      ),
      body: spotifyProvider.trendingSongs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: spotifyProvider.trendingSongs.length,
        itemBuilder: (context, index) {
          final song = spotifyProvider.trendingSongs[index];
          return ListTile(
            title: Text(song.name),
            subtitle: Text(song.artist),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongDetailScreen(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
