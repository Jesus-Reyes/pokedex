
import 'package:flutter/material.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes() {
  return <String, Widget Function(BuildContext)>{
    '/':      (_) => const HomePage(),
    'pokemon':      (_) => const PokemonPage(),
    
  };
}