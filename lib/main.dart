import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/routes/index.dart';
import 'package:pokedex/streams/pokemons_favorites_stream.dart';
import 'package:pokedex/streams/pokemons_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inicializar State
  final pokemonsLocal = await DBPokedex.db.getAllPokemonsLocal();
  final pokemonsFavorites = await DBPokedex.db.getAllFavorites();
  final pokeStream = PokemonsStream();
  final pokeStreamFavorites = PokemonsFavoritesStream();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => PokemonBloc(
        pokemons: pokeStream.streamPokemons,
        pokemonsFavorites: pokeStreamFavorites.streamFavorites,
        initialData: pokemonsLocal,
        initalFavorites: pokemonsFavorites
      )),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      initialRoute: '/',
    );
  }
}
