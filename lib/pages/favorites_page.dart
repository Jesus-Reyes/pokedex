import 'package:flutter/material.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/models/pokemon_favorite.dart';
import 'package:pokedex/services/pokemons_favorites_stream.dart';
import 'package:pokedex/widgets/card_pokemon_favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesStream = PokemonsFavoritesStream();
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
      body: StreamBuilder<List<PokemonFavorite>>(
        stream: favoritesStream.streamFavorites.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return FutureBuilder<void>(
              future: DBPokedex.db.getAllFavorites(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                return Container();
              },
            );
          }

          final favoritesList = snapshot.data!;

          return GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),

            children: favoritesList.map((poke) => CardPokemonFavorite(pokemon: poke)).toList(),
          );
        },
      ),
    );
  }
}
