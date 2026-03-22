import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const Drawer());
}

class Drawer extends StatelessWidget {
  const Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip PRO',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const PublicScreen(),
    );
  }
}

class PublicScreen extends StatelessWidget {
  const PublicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: const Color.fromARGB(255, 105, 228, 113),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                right: 20,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🎰 Sorteador 1-100', // ← Ajuste o número
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Colors.white),
                    onPressed: null, // ← Botão desabilitado
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Body',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
