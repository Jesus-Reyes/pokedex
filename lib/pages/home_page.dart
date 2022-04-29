import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/widgets/card_pokemon.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/widgets/ui/loading_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final poke = PokeApi();
  final isloading = ValueNotifier(false);
  int max = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels ) >= _scrollController.position.maxScrollExtent +100) {
        //Cargar nueva data
        print("MaxExtent ${_scrollController.position.maxScrollExtent +100}");
        print("Curren Pixels ${_scrollController.position.pixels}");
        print("Agregar nuevos pokemons");

        // addPokemons();
      }
    });
  }

  Future<void> addPokemons() async {
    print("AD Pokemon (loading): ${isloading.value}");
    if (isloading.value) return;
    isloading.value = true;
    // await Future.delayed(const Duration(seconds: 3));
    await poke.getPokemonsApi(max);
    isloading.value = false;
    // if (_scrollController.position.pixels + 300 <= _scrollController.position.maxScrollExtent) return;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _space = (size.height > 600) ? 0 : 6.5;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Pokedex", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, 'favorites'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    child: const Text("Favoritos", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                isloading.value = false;
                final pokemons = state.pokemons;
                final min = state.pokemons.length - poke.limit + 1;
                max = state.pokemons.length;

                if (pokemons.isEmpty) {
                  return FutureBuilder<void>(
                    future: poke.getPokemonsApi(max),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: LoadingIcon());
                      }
                      return Container();
                    },
                  );
                }

                return Flexible(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Pokemons: $min - $max", style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GridView.count(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),
                          crossAxisSpacing: 0,
                          children: pokemons.map((pokemon) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, 'pokemon', arguments: pokemon),
                              child: CardPokemon(pokemon: pokemon),
                            );
                          }).toList(),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isloading,
                        child: const LoadingIcon(),
                        builder: (context, loadingValue, child) {
                          if (loadingValue) {
                            return Positioned(
                              bottom: 40,
                              left: size.width * 0.5 - 30,
                              child: child!,
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
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
