part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class SetPokemonsEvent extends PokemonEvent{
  final List<PokemonLocal> pokemons;

  SetPokemonsEvent(this.pokemons);
}


class SetPokemonFavoritesEvent extends PokemonEvent{

  final List<PokemonFavorite> pokemonsFavorites;

  SetPokemonFavoritesEvent(this.pokemonsFavorites);

}