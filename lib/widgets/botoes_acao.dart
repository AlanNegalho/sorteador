import 'package:flutter/material.dart';

class BotoesAcao extends StatelessWidget {
  final bool podeSortear;
  final bool isAnimating;
  final VoidCallback onSortear;
  final VoidCallback onReset;

  const BotoesAcao({
    super.key,
    required this.podeSortear,
    required this.isAnimating,
    required this.onSortear,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (podeSortear && !isAnimating) ? onSortear : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              isAnimating
                  ? '🎡 Sorteando...'
                  : podeSortear
                      ? '🎰 SORTEAR!'
                      : 'Defina o Número primeiro',
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 31, 30, 30),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh, color: Colors.white),
          label: const Text(
            'Novo Sorteio',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
