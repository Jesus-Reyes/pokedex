import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/helpers/getColorPokemon.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_favorite.dart';
import 'package:pokedex/services/pokemons_stream.dart';
import 'package:pokedex/widgets/draggable_info_pokemon.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentPokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    final pokeStream = PokemonsStream();

    return Scaffold(
      backgroundColor: getColorPokemon(currentPokemon.types[0].type.name),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          StreamBuilder<List<Pokemon>>(
            stream: pokeStream.streamPokemons.stream,
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
              final pokemons = snapshot.data!;
              final pokeFavorite = pokemons.firstWhereOrNull((poke) => poke.id == currentPokemon.id);
              return IconButton(
                onPressed: () async {
                  final ByteData imageData = await NetworkAssetBundle(Uri.parse(currentPokemon.sprites.other.dreamWorld.frontDefault)).load("");
                  final Uint8List bytes = imageData.buffer.asUint8List();
                  if (pokeFavorite == null) {
                    final favorite = PokemonFavorite(id: currentPokemon.id, name: currentPokemon.name, img: bytes);
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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentPokemon.name,
                  style: TextStyle(color: Colors.white, fontSize: size.height * 0.062, fontWeight: FontWeight.bold),
                ),
                Text(
                  "# ${currentPokemon.id}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.05,
                  ),
                ),
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
                  child: Text(
                    currentPokemon.types[0].type.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                currentPokemon.types.length > 1
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          currentPokemon.types[1].type.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: currentPokemon.name,
                child: SvgPicture.network(
                  currentPokemon.sprites.other.dreamWorld.frontDefault,
                  semanticsLabel: currentPokemon.name,
                  fit: BoxFit.cover,
                  height: size.height * 0.25,
                  // placeholderBuilder: (_) => const Image(image: AssetImage("assets/jar-loading.gif")),
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

