import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/models/pokemon_favorite.dart';
import 'package:pokedex/models/pokemon_local.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({
    required StreamController<List<PokemonLocal>> pokemons,
    required StreamController<List<PokemonFavorite>> pokemonsFavorites,
    required List<PokemonLocal> initialData,
    required List<PokemonFavorite> initalFavorites,
  }) : super(PokemonState(pokemons: initialData, pokemonsFavorites: initalFavorites)) {
    pokemons.stream.listen(((event) => add(SetPokemonsEvent(event))));
    pokemonsFavorites.stream.listen(((event) => add(SetPokemonFavoritesEvent(event))));

    on<SetPokemonsEvent>((event, emit) => emit(state.copyWith(pokemons: [...event.pokemons])));
    on<SetPokemonFavoritesEvent>((event, emit) => emit(state.copyWith(pokemonsFavorites: [...event.pokemonsFavorites])));
    // on<InitialDataEvent>((event, emit) => emit(state.copyWith(pokemons: event.initialData)));
  }
}
