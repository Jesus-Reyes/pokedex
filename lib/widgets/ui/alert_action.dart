import 'package:flutter/material.dart';

class AlertAction extends StatelessWidget {
  const AlertAction({Key? key, required this.message, required this.status}) : super(key: key);
  final String message;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: status ? Colors.green : Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: status ? const Icon(Icons.check, color: Colors.white, size: 20) : const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          Text(message, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
