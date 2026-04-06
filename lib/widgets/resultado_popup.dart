import 'package:flutter/material.dart';
import '../services/image_service.dart';

class ResultadoPopup extends StatelessWidget {
  final int numero;
  final DateTime agora;
  final GlobalKey globalKey;

  const ResultadoPopup({
    super.key,
    required this.numero,
    required this.agora,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          '🎉 Numero Sorteado:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          numero.toString(),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Data: ${agora.day}/${agora.month}/${agora.year}',
                        ),
                        Text(
                          'Hora: ${agora.hour}:${agora.minute.toString().padLeft(2, '0')}',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => ImageService.salvar(globalKey, context),
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar resultado'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
