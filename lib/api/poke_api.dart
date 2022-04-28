import 'package:dio/dio.dart';

class PokeApi {

  static final PokeApi _instance = PokeApi._internal();
  factory PokeApi() => _instance;
  PokeApi._internal();

  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final dio = Dio();

  Future getPokemons() async {
    final response = await dio.get(baseUrl + '?limit=100');
    print(response.data);
  }
}
