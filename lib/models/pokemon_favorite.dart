import 'dart:convert';

import 'dart:typed_data';

class PokemonFavorite {
    PokemonFavorite({
        required this.id,
        required this.name,
        required this.img,
    });

    final int id;
    final String name;
    final Uint8List img;

    PokemonFavorite copyWith({
        int ? id,
        String ? name,
        Uint8List ? img,
    }) => 
        PokemonFavorite(
            id: id ?? this.id,
            name: name ?? this.name,
            img: img ?? this.img,
        );

    factory PokemonFavorite.fromJson(String str) => PokemonFavorite.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonFavorite.fromMap(Map<String, dynamic> json) => PokemonFavorite(
        id: json["id"],
        name: json["name"],
        img: json["img"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "img": img,
    };
}
