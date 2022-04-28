import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/services/pokemons_stream.dart';

class PokeApi {
  static final PokeApi _instance = PokeApi._internal();
  factory PokeApi() => _instance;
  PokeApi._internal();

  final pokemonStream = PokemonsStream();

  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final dio = Dio();

  Future<List<Pokemon>> getPokemons() async {
    final response = await dio.get(baseUrl + '?limit=20');
    final pokemonsList = PokemonList.fromMap(response.data);

    final responses = await Future.wait(pokemonsList.results.map((poke) => dio.get(baseUrl + '/${poke.name}')).toList());

    final pokemons= await Future.wait(responses.map((resp) async {
      final data = resp.data as Pokemon;
      final ByteData imageData = await NetworkAssetBundle(Uri.parse(data.sprites.other.dreamWorld.frontDefault)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();
      Map<String, dynamic> poke =  data.toMap();
      poke['imgLocal'] = bytes;
      final currentPokemon = Pokemon.fromMap(poke);
      return currentPokemon;
    }).toList());
    
    // final pokemons = responses.map((resp) => Pokemon.fromMap(resp.data)).toList();

    return pokemons;
  }
}
