import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/widgets/ui/alert_action.dart';
import 'package:pokedex/widgets/ui/card_pokemon.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/widgets/ui/loading_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final poke = PokeApi();
  final ScrollController _scrollController = ScrollController();
  final isloading = ValueNotifier(false);
  final indexBloque = ValueNotifier(0);

  int min = 0;
  int max = 0;
  int endBloque = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels) >= _scrollController.position.maxScrollExtent + 100) {
        indexBloque.value + 1 >= endBloque ? addPokemons() : nextPokemons();
      }
    });
  }

  Future<void> addPokemons() async {
    if (isloading.value) return;
    isloading.value = true;
    final success = await poke.getPokemonsApi(max);
    if (!success) {
      Future.delayed(
        Duration.zero,
        () => showDialog(
          context: context,
          builder: (_) {
            Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
            return const AlertAction(
              message: "Checa tu conexion a Internet",
              status: false,
            );
          },
        ),
      );
    } else {
      indexBloque.value++;
    }
    isloading.value = false;
  }

  Future<void> nextPokemons() async {
    if (isloading.value) return;
    isloading.value = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    isloading.value = false;
    indexBloque.value++;
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
  }

  Future<void> backPokemons() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (indexBloque.value > 0) {
      indexBloque.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _space = (size.height > 600) ? 8 : 6.5;

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
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade300),
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
                final totalPokemons = state.pokemons;
                endBloque = totalPokemons.length ~/ poke.limit;

                if (totalPokemons.isEmpty) {
                  return FutureBuilder<bool>(
                    future: poke.getPokemonsApi(state.pokemons.length),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: LoadingIcon());
                      }
                      final status = snapshot.data!;
                      if (!status) {
                        Future.delayed(
                          Duration.zero,
                          () {
                            Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                            return showDialog(
                              context: context,
                              builder: (_) => const AlertAction(
                                message: "Checa tu conexion a Internet",
                                status: false,
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  );
                }

                return ValueListenableBuilder<int>(
                  valueListenable: indexBloque,
                  builder: (context, indexValue, child) {
                    min = indexValue * poke.limit;
                    max = indexValue * poke.limit + poke.limit;
                    final blockPokemons = totalPokemons.skip(min).take(poke.limit);

                    return Flexible(
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Bloque:${indexValue + 1} ", style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                              Text("Pokemons: ${min + 1} - $max", style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                              Text("Poke Local: ${totalPokemons.length}", style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RefreshIndicator(
                              color: Colors.red,
                              onRefresh: backPokemons,
                              child: GridView.count(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                childAspectRatio: (size.width / (size.height - kToolbarHeight * _space * 0.5)),
                                crossAxisSpacing: 0,
                                children: blockPokemons.map((pokemon) {
                                  return GestureDetector(
                                    onTap: () => Navigator.pushNamed(context, 'pokemon', arguments: pokemon),
                                    child: CardPokemon(pokemon: pokemon),
                                  );
                                }).toList(),
                              ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
