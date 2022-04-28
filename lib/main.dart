import 'package:flutter/material.dart';
import 'package:pokedex/db/db_pokedex.dart';
import 'package:pokedex/routes/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBPokedex.db.getAllFavorites();
  
  runApp(const MyApp());
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
