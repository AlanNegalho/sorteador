import 'package:flutter/material.dart';

class NumeroDisplay extends StatelessWidget {
  final int numero;

  const NumeroDisplay({super.key, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black26,
          )
        ],
      ),
      child: Center(
        child: Text(
          numero.toString(),
          style: const TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
