import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/widgets/card_pokemon.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poke = PokeApi();
    final size = MediaQuery.of(context).size;
    final _space = (size.height > 600) ? 0 : 6.5;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Pokedex",
                    style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, 'favorites'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    child: const Text(
                      "Favoritos",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                final pokemons = state.pokemons;
                
                if (pokemons.isEmpty) {
                  return FutureBuilder<void>(
                    future: poke.getPokemonsApi(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.red,),
                        );
                      }
                      return Container();
                    },
                  );
                }

                return Flexible(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),
                    crossAxisSpacing: 0,
                    children: pokemons.map((pokemon) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'pokemon', arguments: pokemon),
                        child: CardPokemon(
                          pokemon: pokemon,
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
