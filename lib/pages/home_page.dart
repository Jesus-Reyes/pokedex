import 'package:flutter/material.dart';
import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/services/pokemons_stream.dart';
import 'package:pokedex/widgets/card_pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poke = PokeApi();
    final pokeStream = PokemonsStream();

    return Scaffold(
      appBar: AppBar(title: const Text("POkedex")),
      body: StreamBuilder<List<Pokemon>>(
        stream: pokeStream.streamPokemons.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return FutureBuilder<List<Pokemon>>(
              future: poke.getPokemons(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                final pokemons = snapshot.data!;
                pokeStream.streamPokemons.add(pokemons);
                return Container();
              },
            );
          }
          final pokemons = snapshot.data!;
          return ListView.builder(
            // itemCount: pokemonsList.results.length,
            itemCount: 21,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return CardPokemon(
                name: pokemon.name,
                frontDefault: pokemon.sprites.frontDefault,
                type1: pokemon.types[0].type.name,
                type2: pokemon.types.length > 1 ? pokemon.types[0].type.name : null,
              );
            },
          );
        },
      ),
    );
  }
}
