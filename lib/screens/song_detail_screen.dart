import 'package:flutter/material.dart';
import '../models/spotify_model.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  const SongDetailScreen({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Artist: ${song.artist}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Album: ${song.album}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Release Date: ${song.releaseDate}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
