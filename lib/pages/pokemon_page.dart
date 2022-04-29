import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/helpers/get_color_pokemon.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_favorite.dart';
import 'package:pokedex/models/pokemon_local.dart';
import 'package:pokedex/widgets/ui/draggable_info_pokemon.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentPokemon = ModalRoute.of(context)!.settings.arguments as PokemonLocal;

    final List<dynamic> dataTypes = jsonDecode(currentPokemon.types);
    final types = dataTypes.map((e) => Type.fromMap(e)).toList();

    return Scaffold(
      backgroundColor: getColorPokemon(types[0].type.name),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              final favorites = state.pokemonsFavorites; // Favoritos
              final pokeFavorite = favorites.firstWhereOrNull((poke) => poke.id == currentPokemon.id);

              return IconButton(
                onPressed: () async {
                  if (pokeFavorite == null) {
                    final favorite = PokemonFavorite(id: currentPokemon.id, name: currentPokemon.name);
                    await DBPokedex.db.addPokemonFavorite(favorite);
                  } else {
                    DBPokedex.db.deletePokemonFavorite(pokeFavorite.id);
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  (pokeFavorite == null) ? Icons.favorite_border : Icons.favorite,
                  color: (pokeFavorite == null) ? Colors.white : Colors.red,
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    currentPokemon.name,
                    style: TextStyle(color: Colors.white, fontSize: size.height * 0.062, fontWeight: FontWeight.bold),
                  ),
                ),
                Text("# ${currentPokemon.id}", style: TextStyle(color: Colors.white, fontSize: size.height * 0.05)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                  child: Text(types[0].type.name, style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                if (types.length > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                    child: Text(types[1].type.name, style: const TextStyle(color: Colors.white)),
                  )
                else
                  Container(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentPokemon.id <= 649)
                Hero(
                  tag: currentPokemon.name,
                  child: SvgPicture.memory(
                    currentPokemon.imgLocal,
                    semanticsLabel: currentPokemon.name,
                    fit: BoxFit.cover,
                    height: size.height * 0.13,
                    placeholderBuilder: (_) => Image(
                      height: size.height * 0.1,
                      image: const AssetImage("assets/jar-loading.gif"),
                    ),
                  ),
                )
              else
                Hero(
                  tag: currentPokemon.name,
                  child: Image.memory(
                    currentPokemon.imgLocal,
                    fit: BoxFit.cover,
                    height: size.height * 0.13,
                  ),
                ),
            ],
          ),
          DraggableInfoPokemon(currentPokemon: currentPokemon)
        ],
      ),
    );
  }
}
