import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/models/pokemon_local.dart';
import 'package:pokedex/streams/pokemons_stream.dart';

class PokeApi {
  static final PokeApi _instance = PokeApi._internal();
  factory PokeApi() => _instance;
  PokeApi._internal();

  final dio = Dio();
  final pokemonStream = PokemonsStream();
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  int limit = 50;

  Future<bool> getPokemonsApi(int offset) async {
    try {
      dio.options.connectTimeout = 5000;
      final response = await dio.get(baseUrl + '?limit=$limit&offset=$offset');
      
      final pokemonsList = PokemonList.fromMap(response.data);

      final responses = await Future.wait(pokemonsList.results.map((poke) => dio.get(baseUrl + '/${poke.name}')).toList());
      final pokemons = responses.map((resp) => Pokemon.fromMap(resp.data)).toList();

      final imagesLocal = await Future.wait(pokemons.map((poke) async {
        final spritesOther = poke.sprites.other;
        return getImageLocal(spritesOther.dreamWorld.frontDefault ?? spritesOther.home.frontDefault);
      }).toList());

      final pokemonsLocal = pokemons.map((poke) {
        final index = pokemons.indexOf(poke);
        return pokemonsToLocal(poke, index, imagesLocal);
      }).toList();

      DBPokedex.db.addPokemonsLocal(pokemonsLocal);
      return true;
    } catch (e) {

      return false;
    }
  }

  Future<Uint8List> getImageLocal(String url) async {
    final ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();

    return bytes;
  }

  PokemonLocal pokemonsToLocal(Pokemon poke, int index, List<Uint8List> imagesLocal) {
    final Map<String, dynamic> mapPoke = {
      "id": poke.id,
      "abilities": poke.abilities.map((ability) => ability.toJson()).toList().toString(),
      "game_indices": poke.gameIndices.map((game) => game.toJson()).toList().toString(),
      "height": poke.height,
      "name": poke.name,
      "sprites": poke.sprites.other.dreamWorld.frontDefault ?? poke.sprites.other.home.frontDefault,
      "stats": poke.stats.map((s) => s.toJson()).toList().toString(),
      "types": poke.types.map((type) => type.toJson()).toList().toString(),
      "weight": poke.weight,
      "img_local": imagesLocal[index]
    };
    return PokemonLocal.fromMap(mapPoke);
  }
}
