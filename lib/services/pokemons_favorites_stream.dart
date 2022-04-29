import 'dart:async';
import 'package:pokedex/models/pokemon_favorite.dart';

class PokemonsFavoritesStream {
  static final PokemonsFavoritesStream _instance = PokemonsFavoritesStream._internal();
  factory PokemonsFavoritesStream() => _instance;
  PokemonsFavoritesStream._internal();

  final StreamController<List<PokemonFavorite>>  _pokemonsListFavorites = StreamController<List<PokemonFavorite>>.broadcast();

  StreamController<List<PokemonFavorite>>  get streamFavorites => _pokemonsListFavorites;

}
