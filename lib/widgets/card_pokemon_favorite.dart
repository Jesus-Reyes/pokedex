import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/models/pokemon_favorite.dart';

class CardPokemonFavorite extends StatelessWidget {
  const CardPokemonFavorite({Key? key, required this.pokemon}) : super(key: key);

  final PokemonFavorite pokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.memory(
                  pokemon.img,
                  width: size.width * 0.1,
                  height: size.height * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1).toLowerCase(),
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
