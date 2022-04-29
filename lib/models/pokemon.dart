import 'dart:convert';

class Pokemon {
  Pokemon({
    required this.abilities,
    required this.gameIndices,
    required this.height,
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  final List<AbilityElement> abilities;
  final List<GameIndex> gameIndices;
  final int height;
  final int id;
  final String name;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  Pokemon copyWith({
    List<AbilityElement>? abilities,
    List<GameIndex>? gameIndices,
    int? height,
    int? id,
    String? name,
    Sprites? sprites,
    List<Stat>? stats,
    List<Type>? types,
    int? weight,
  }) =>
      Pokemon(
        abilities: abilities ?? this.abilities,
        gameIndices: gameIndices ?? this.gameIndices,
        height: height ?? this.height,
        id: id ?? this.id,
        name: name ?? this.name,
        sprites: sprites ?? this.sprites,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        weight: weight ?? this.weight,
      );

  factory Pokemon.fromJson(String str) => Pokemon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        abilities: List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromMap(x))),
        gameIndices: List<GameIndex>.from(json["game_indices"].map((x) => GameIndex.fromMap(x))),
        height: json["height"],
        id: json["id"],
        name: json["name"],
        sprites: Sprites.fromMap(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toMap())),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toMap())),
        "height": height,
        "id": id,
        "name": name,
        "sprites": sprites.toMap(),
        "stats": List<dynamic>.from(stats.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
        "weight": weight,
      };
}

class AbilityElement {
  AbilityElement({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final VersionClass ability;
  final bool isHidden;
  final int slot;

  AbilityElement copyWith({
    VersionClass? ability,
    bool? isHidden,
    int? slot,
  }) =>
      AbilityElement(
        ability: ability ?? this.ability,
        isHidden: isHidden ?? this.isHidden,
        slot: slot ?? this.slot,
      );

  factory AbilityElement.fromJson(String str) => AbilityElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbilityElement.fromMap(Map<String, dynamic> json) => AbilityElement(
        ability: VersionClass.fromMap(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability.toMap(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class VersionClass {
  VersionClass({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  VersionClass copyWith({
    String? name,
    String? url,
  }) =>
      VersionClass(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory VersionClass.fromJson(String str) => VersionClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionClass.fromMap(Map<String, dynamic> json) => VersionClass(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class GameIndex {
  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  final int gameIndex;
  final VersionClass version;

  GameIndex copyWith({
    int? gameIndex,
    VersionClass? version,
  }) =>
      GameIndex(
        gameIndex: gameIndex ?? this.gameIndex,
        version: version ?? this.version,
      );

  factory GameIndex.fromJson(String str) => GameIndex.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GameIndex.fromMap(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        version: VersionClass.fromMap(json["version"]),
      );

  Map<String, dynamic> toMap() => {
        "game_index": gameIndex,
        "version": version.toMap(),
      };
}

class Sprites {
  Sprites({
    required this.other,
  });

  final Other other;

  Sprites copyWith({
    Other? other,
  }) =>
      Sprites(
        other: other ?? this.other,
      );

  factory Sprites.fromJson(String str) => Sprites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        other: Other.fromMap(json["other"]),
      );

  Map<String, dynamic> toMap() => {
        "other": other.toMap(),
      };
}

class Other {
  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });

  final DreamWorld dreamWorld;
  final Home home;
  final OfficialArtwork officialArtwork;

  Other copyWith({
    DreamWorld? dreamWorld,
    Home? home,
    OfficialArtwork? officialArtwork,
  }) =>
      Other(
        dreamWorld: dreamWorld ?? this.dreamWorld,
        home: home ?? this.home,
        officialArtwork: officialArtwork ?? this.officialArtwork,
      );

  factory Other.fromJson(String str) => Other.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Other.fromMap(Map<String, dynamic> json) => Other(
        dreamWorld: DreamWorld.fromMap(json["dream_world"]),
        home: Home.fromMap(json["home"]),
        officialArtwork: OfficialArtwork.fromMap(json["official-artwork"]),
      );

  Map<String, dynamic> toMap() => {
        "dream_world": dreamWorld.toMap(),
        "home": home.toMap(),
        "official-artwork": officialArtwork.toMap(),
      };
}

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  final String frontDefault;
  final dynamic frontFemale;

  DreamWorld copyWith({
    String? frontDefault,
    dynamic frontFemale,
  }) =>
      DreamWorld(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
      );

  factory DreamWorld.fromJson(String str) => DreamWorld.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DreamWorld.fromMap(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
      };
}

class Home {
  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  Home copyWith({
    String? frontDefault,
    dynamic frontFemale,
    String? frontShiny,
    dynamic frontShinyFemale,
  }) =>
      Home(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyFemale: frontShinyFemale ?? this.frontShinyFemale,
      );

  factory Home.fromJson(String str) => Home.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Home.fromMap(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
  });

  final String frontDefault;

  OfficialArtwork copyWith({
    String? frontDefault,
  }) =>
      OfficialArtwork(
        frontDefault: frontDefault ?? this.frontDefault,
      );

  factory OfficialArtwork.fromJson(String str) => OfficialArtwork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfficialArtwork.fromMap(Map<String, dynamic> json) => OfficialArtwork(
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
      };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  final int baseStat;
  final int effort;
  final VersionClass stat;

  Stat copyWith({
    int? baseStat,
    int? effort,
    VersionClass? stat,
  }) =>
      Stat(
        baseStat: baseStat ?? this.baseStat,
        effort: effort ?? this.effort,
        stat: stat ?? this.stat,
      );

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: VersionClass.fromMap(json["stat"]),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toMap(),
      };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  final int slot;
  final VersionClass type;

  Type copyWith({
    int? slot,
    VersionClass? type,
  }) =>
      Type(
        slot: slot ?? this.slot,
        type: type ?? this.type,
      );

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: VersionClass.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
      };
}
