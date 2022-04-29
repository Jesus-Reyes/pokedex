import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/widgets/ui/card_pokemon_favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _space = (size.height > 600) ? 2 : 4;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.red.shade300,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text("Favoritos", style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              final pokemons = state.pokemons;
              final favoritesPoke = state.pokemonsFavorites;
              if (favoritesPoke.isEmpty) {
                return const Center(
                  child: Text(
                    "No tienes pokemons favoritos",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              }

              return GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),
                children: favoritesPoke.map((pokeFavorite) {
                  final poke = pokemons.where((poke) => poke.id == pokeFavorite.id).first;
                  final List<dynamic> dataTypes = jsonDecode(poke.types);
                  final types = dataTypes.map((e) => Type.fromMap(e)).toList();

                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'pokemon', arguments: poke),
                    child: CardPokemonFavorite(
                      pokemon: pokeFavorite,
                      img: poke.imgLocal,
                      type: types[0].type.name,
                    ),
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
