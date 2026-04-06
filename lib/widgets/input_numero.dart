import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumero extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const InputNumero({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '📝 Número máximo:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange[700],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Card(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Ex: 100, 250..',
                    prefixText: '1 a ',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
