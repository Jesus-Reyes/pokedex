import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/card_pokemon_favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _space = (size.height > 600) ? 2 : 4;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.transparent,
          title: const Text(
            "Favoritos",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            final pokemons = state.pokemons;
            final favoritesPoke = state.pokemonsFavorites;

            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),
              children: favoritesPoke.map((pokeFavorite) {
                final poke = pokemons.where((poke) => poke.id == pokeFavorite.id).first;
                final List<dynamic> dataTypes = jsonDecode(poke.types);
                final types = dataTypes.map((e) => Type.fromMap(e)).toList();

                return CardPokemonFavorite(
                  pokemon: pokeFavorite,
                  img: poke.imgLocal,
                  type: types[0].type.name,
                );
              }).toList(),
            );
          },
        ));
  }
}
