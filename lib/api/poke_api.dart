import 'package:dio/dio.dart';
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
    final pokemons = responses.map((resp) => Pokemon.fromMap(resp.data)).toList();

    return pokemons;
  }


}
