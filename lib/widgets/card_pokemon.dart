import 'package:flutter/material.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key? key,
    required this.name, required this.frontDefault, required this.type1, required this.type2,

  }) : super(key: key);

  final String name;
  final String frontDefault;
  final String type1;
  final String ? type2;
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: SizedBox(
          height: size.height * 0.3,
          // color: Colors.red,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image Rockets
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FadeInImage(
                      width: size.width * 0.28,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage("assets/jar-loading.gif"),
                      image: NetworkImage(frontDefault),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: size.width * 0.6,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          type1,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            type2?? "",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
