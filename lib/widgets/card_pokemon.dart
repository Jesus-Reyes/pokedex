import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/helpers/getColorPokemon.dart';
import 'package:pokedex/models/pokemon.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        color: getColorPokemon(pokemon.types[0].type.name),
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
              Hero(
                
                tag: pokemon.name,
                // child: FadeInImage(
                //   width: size.width * 0.3,
                //   fit: BoxFit.cover,
                //   placeholder: const AssetImage("assets/jar-loading.gif"),
                //   image: NetworkImage(pokemon.sprites.frontDefault),
                // ),
                child: SvgPicture.network(
                  pokemon.sprites.other.dreamWorld.frontDefault,
                  semanticsLabel: pokemon.name,
                  fit: BoxFit.cover,
                  height: size.height * 0.15,
                  placeholderBuilder: (_) => const Image(image: AssetImage("assets/jar-loading.gif")),
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
                      pokemon.types[0].type.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  pokemon.types.length > 1 ? 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      pokemon.types[1].type.name ,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ): Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
