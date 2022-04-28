import 'package:flutter/material.dart';

class StatsPokemon extends StatelessWidget {
  const StatsPokemon({Key? key, required this.baseStat, required this.nameStat}) : super(key: key);
  final List<int> baseStat;
  final List<String> nameStat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                
                width: size.width * 0.4,
                height: size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...nameStat.map((e) => Text(e, style: TextStyle(fontSize: 16, color: Colors.grey.shade700),)).toList(),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.42,
                height: size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...baseStat.map((val) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(val.toString()),
                          const SizedBox(width: 10,),
                          Flexible(
                            child: LinearProgressIndicator(
                              value: val / 100,
                              backgroundColor: Colors.grey.shade300,
                              color: val /100 > 0.5 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
