import 'package:flutter/material.dart';



class GamesPokemon extends StatelessWidget {
  const GamesPokemon({ Key? key, required this.gameIndexs, required this.gameNames }) : super(key: key);
  final List<int> gameIndexs;
  final List<String> gameNames;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Game Index",  style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
              Text("Game Name",  style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: gameIndexs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: size.width *0.4,
                          child: Column(
                            children: [
                              Text(gameIndexs[index].toString(), style: const TextStyle(fontSize: 15, color: Colors.black))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width *0.4,
                          child: Column(
                            children: [
                              Text(gameNames[index].toString(), style: const TextStyle(fontSize: 15, color: Colors.black))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            
          ),
        ),
      ],
    );
  }
}