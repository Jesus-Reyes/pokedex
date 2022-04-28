import 'package:flutter/material.dart';

class AboutPokemon extends StatelessWidget {
  const AboutPokemon({
    Key? key,
    required this.abilities,
    required this.height,
    required this.weight,
  }) : super(key: key);
  final List<String> abilities;
  final int height;
  final int weight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Abilities:",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              ...abilities.map((ability) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ability,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList()
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width * 0.4,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weight: ",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Text(
                  "$weight kg",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width * 0.4,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Height: ",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Text(
                  "$height cm",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
