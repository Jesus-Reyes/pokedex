import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_local.dart';
import 'package:pokedex/helpers/get_color_pokemon.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({Key? key, required this.pokemon}) : super(key: key);

  final PokemonLocal pokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<dynamic> dataTypes = jsonDecode(pokemon.types);
    final types = dataTypes.map((e) => Type.fromMap(e)).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        color: getColorPokemon(types[0].type.name),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pokemon.id <= 649
                  ? Hero(
                      tag: pokemon.name,
                      child: SvgPicture.memory(
                        pokemon.imgLocal,
                        semanticsLabel: pokemon.name,
                        fit: BoxFit.cover,
                        height: size.height * 0.13,
                        placeholderBuilder: (_) => Image(
                          height: size.height * 0.1,
                          image: const AssetImage("assets/jar-loading.gif"),
                        ),
                      ),
                    )
                  : Hero(
                      tag: pokemon.name,
                      child: Image.memory(
                        pokemon.imgLocal,
                        fit: BoxFit.cover,
                        height: size.height * 0.13,
                      ),
                      
                    ),
              Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1).toLowerCase(),
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      types[0].type.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  types.length > 1
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            types[1].type.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
