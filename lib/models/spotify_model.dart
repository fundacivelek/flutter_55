class Song {
  final String id;
  final String name;
  final String artist;
  final String album;
  final String releaseDate;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.album,
    required this.releaseDate,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      artist: json['artists'][0]['name'],
      album: json['album']['name'],
      releaseDate: json['release_date'],
    );
  }
}

class Artist {
  final String id;
  final String name;
  final int followers;
  final int popularity;

  Artist({
    required this.id,
    required this.name,
    required this.followers,
    required this.popularity,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      followers: json['followers']['total'],
      popularity: json['popularity'],
    );
  }
}
