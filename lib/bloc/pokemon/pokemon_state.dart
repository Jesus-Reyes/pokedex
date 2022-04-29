part of 'pokemon_bloc.dart';

class PokemonState {
  final List<PokemonLocal> pokemons;
  final List<PokemonFavorite> pokemonsFavorites;

  const PokemonState({required this.pokemons, required this.pokemonsFavorites});

  PokemonState copyWith({
    List<PokemonLocal>? pokemons,
    List<PokemonFavorite>? pokemonsFavorites,
  }) =>
      PokemonState(
        pokemons: pokemons ?? this.pokemons,
        pokemonsFavorites: pokemonsFavorites ?? this.pokemonsFavorites,
      );
}
