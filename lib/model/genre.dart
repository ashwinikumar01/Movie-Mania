// To parse this JSON data, do
//
//     final genre = genreFromJson(jsonString);

import 'dart:convert';

Genre genreFromJson(String str) => Genre.fromJson(json.decode(str));

String genreToJson(Genre data) => json.encode(data.toJson());

class Genre {
  Genre({
    this.genres,
  });

  List<GenreElement> genres;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genres: List<GenreElement>.from(
            json["genres"].map((x) => GenreElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class GenreElement {
  GenreElement({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory GenreElement.fromJson(Map<String, dynamic> json) => GenreElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
