import 'package:flutter/material.dart';
import 'package:pokedex/helpers/getColorPokemon.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
  final size = MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor: getColorPokemon(pokemon.types[0].type.name),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: pokemon.name,
            child: FadeInImage(
              width: size.width * 0.5,
              fit: BoxFit.cover,
              placeholder: const AssetImage("assets/jar-loading.gif"),
              image: NetworkImage(pokemon.sprites.frontDefault),
            ),
          ),
        ],
      ),
    );
  }
}
