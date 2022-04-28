import 'dart:io';
import 'package:path/path.dart';
import 'package:pokedex/models/pokemon_favorite.dart';
import 'package:pokedex/services/pokemons_stream.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBPokedex {
  static Database? _database;

  static final DBPokedex db = DBPokedex._();

  DBPokedex._();

  final pokeStream = PokemonsStream();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pokedex.db');

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE PokemonFavorites(
            id INTEGER,
            name TEXT,
            img Uint8List
          )
          ''');
      },
    );
  }

  Future<int> addPokemonFavorite(PokemonFavorite pokemonFavorite) async {
    final db = await database;
    final res = await db.insert('PokemonFavorites', pokemonFavorite.toMap());
    getAllFavorites();
    return res;
  }

  Future<int> deletePokemonFavorite(int id) async {
    final db = await database;
    final res = await db.delete('PokemonFavorites', where: 'id = ?', whereArgs: [id]);
    getAllFavorites();
    return res;
  }

  Future<void> getAllFavorites() async {
    final db = await database;
    final res = await db.query('PokemonFavorites');
    final List<PokemonFavorite> list = res.isNotEmpty ? res.map((c) => PokemonFavorite.fromMap(c)).toList() : [];
    pokemonsFavorites.streamFavorites.add(list);
  }
}
