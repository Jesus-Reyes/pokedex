import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_local.dart';

class PokemonsStream {
  static final PokemonsStream _instance = PokemonsStream._internal();
  factory PokemonsStream() => _instance;
  PokemonsStream._internal();

  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final dio = Dio();

  final StreamController<List<PokemonLocal>>  _pokemonsList = StreamController<List<PokemonLocal>> .broadcast();

  StreamController<List<PokemonLocal>>  get streamPokemons => _pokemonsList;

}
