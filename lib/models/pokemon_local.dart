
import 'dart:convert';
import 'dart:typed_data';

class PokemonLocal {
    PokemonLocal({
        required this.id,
        required this.abilities,
        required this.gameIndices,
        required this.height,
        required this.name,
        required this.sprites,
        required this.stats,
        required this.types,
        required this.weight,
        required this.imgLocal
    });

    final int id;
    final String abilities;
    final String gameIndices;
    final int height;
    final String name;
    final String sprites;
    final String stats;
    final String types;
    final int weight;
    final Uint8List imgLocal;

    PokemonLocal copyWith({
        int ?  id,
        String ?  abilities,
        String ?  gameIndices,
        int ?  height,
        String ?  name,
        String ?  sprites,
        String ?  stats,
        String ?  types,
        int ?  weight,
        Uint8List? imgLocal
    }) => 
        PokemonLocal(
            id: id ?? this.id,
            abilities: abilities ?? this.abilities,
            gameIndices: gameIndices ?? this.gameIndices,
            height: height ?? this.height,
            name: name ?? this.name,
            sprites: sprites ?? this.sprites,
            stats: stats ?? this.stats,
            types: types ?? this.types,
            weight: weight ?? this.weight,
            imgLocal: imgLocal ?? this.imgLocal,
        );

    factory PokemonLocal.fromJson(String str) => PokemonLocal.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonLocal.fromMap(Map<String, dynamic> json) => PokemonLocal(
        id: json["id"],
        abilities: json["abilities"],
        gameIndices: json["game_indices"],
        height: json["height"],
        name: json["name"],
        sprites: json["sprites"],
        stats: json["stats"],
        types: json["types"],
        weight: json["weight"],
        imgLocal: json["img_local"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "abilities": abilities,
        "game_indices": gameIndices,
        "height": height,
        "name": name,
        "sprites": sprites,
        "stats": stats,
        "types": types,
        "weight": weight,
        "img_local": imgLocal,
    };
}
