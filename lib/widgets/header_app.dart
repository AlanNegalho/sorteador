import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget {
  final int maxNumero;

  const HeaderApp({super.key, required this.maxNumero});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 105, 228, 113),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            maxNumero > 0 ? '🎰 Sorteador 1-$maxNumero' : '🎰 Sorteador',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}
