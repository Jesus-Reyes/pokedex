import 'dart:convert';
class PokemonFavorite {
    PokemonFavorite({
        required this.id,
        required this.name,
        
    });

    final int id;
    final String name;

    PokemonFavorite copyWith({
        int ? id,
        String ? name,
    }) => 
        PokemonFavorite(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory PokemonFavorite.fromJson(String str) => PokemonFavorite.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonFavorite.fromMap(Map<String, dynamic> json) => PokemonFavorite(
        id: json["id"],
        name: json["name"],
        
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
