import 'dart:convert';

class PokemonList {
    PokemonList({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    final int count;
    final String next;
    final dynamic previous;
    final List<Result> results;

    PokemonList copyWith({
        int ? count,
        String ? next,
        dynamic  previous,
        List<Result> ? results,
    }) => 
        PokemonList(
            count: count ?? this.count,
            next: next ?? this.next,
            previous: previous ?? this.previous,
            results: results ?? this.results,
        );

    factory PokemonList.fromJson(String str) => PokemonList.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonList.fromMap(Map<String, dynamic> json) => PokemonList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Result {
    Result({
        required this.name,
        required this.url,
    });

    final String name;
    final String url;

    Result copyWith({
        String ? name,
        String ? url,
    }) => 
        Result(
            name: name ?? this.name,
            url: url ?? this.url,
        );

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
    };
}
