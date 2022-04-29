


import 'package:flutter/material.dart' show Color;
import 'package:pokedex/utils/colors_pokemon.dart';

Color getColorPokemon(String type){

  final t = colorsPokemon[type]!; 

  return t;


}