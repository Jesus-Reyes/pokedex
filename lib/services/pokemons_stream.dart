import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonsStream {
  static final PokemonsStream _instance = PokemonsStream._internal();
  factory PokemonsStream() => _instance;
  PokemonsStream._internal();

  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final dio = Dio();

  final StreamController<List<Pokemon>>  _pokemonsList = StreamController<List<Pokemon>> .broadcast();

  StreamController<List<Pokemon>>  get streamPokemons => _pokemonsList;

}
