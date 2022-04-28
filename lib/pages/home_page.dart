import 'package:flutter/material.dart';
import 'package:pokedex/api/poke_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poke = PokeApi();

    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () async {
            poke.getPokemons();
          },
        ),
      ),
    );
  }
}
