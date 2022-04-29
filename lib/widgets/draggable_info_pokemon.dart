import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/helpers/get_color_pokemon.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_local.dart';
import 'package:pokedex/widgets/about_pokemon.dart';
import 'package:pokedex/widgets/games_pokemon.dart';
import 'package:pokedex/widgets/stats_pokemon.dart';

class DraggableInfoPokemon extends StatelessWidget {
  const DraggableInfoPokemon({
    Key? key,
    required this.currentPokemon,
  }) : super(key: key);

  final PokemonLocal currentPokemon;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> dataTypes = jsonDecode(currentPokemon.types);
    final types = dataTypes.map((e) => Type.fromMap(e)).toList();
    final currentColor = getColorPokemon(types[0].type.name);

    

    final List<dynamic> dataStats  = jsonDecode(currentPokemon.stats);
    final stats = dataStats.map((s) => Stat.fromMap(s)).toList();

    final List<dynamic> dataGames  = jsonDecode(currentPokemon.gameIndices);
    final games = dataGames.map((g) => GameIndex.fromMap(g)).toList();

    final List<dynamic> dataAbilities  = jsonDecode(currentPokemon.abilities);
    final abilities = dataAbilities.map((a) => AbilityElement.fromMap(a)).toList();
 

   

    return Flexible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.1,
        builder: (context, scrollController) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: currentColor,
              appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: SafeArea(
                  child: AppBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 0.0),
                      child: TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(width: 2, color: currentColor), insets: const EdgeInsets.symmetric(horizontal: 20.0)),
                        tabs: const [
                          Tab(child: Text("About", style: TextStyle(color: Colors.black))),
                          Tab(child: Text("Stats", style: TextStyle(color: Colors.black))),
                          Tab(child: Text("Games", style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                    child: PageView(
                      children: [
                        AboutPokemon(
                          abilities: abilities.map((e) => e.ability.name).toList(),
                          height: currentPokemon.height,
                          weight: currentPokemon.weight,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: PageView(
                      children: [
                        StatsPokemon(
                          baseStat: stats.map((stat) => stat.baseStat).toList(),
                          nameStat: stats.map((stat) => stat.stat.name).toList(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: PageView(
                      children: [
                        GamesPokemon(
                          gameIndexs: games.map((game) => game.gameIndex).toList(),
                          gameNames: games.map((game) => game.version.name).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
