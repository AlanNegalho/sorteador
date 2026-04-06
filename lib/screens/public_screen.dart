import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../widgets/header_app.dart';
import '../widgets/input_numero.dart';
import '../widgets/numero_display.dart';
import '../widgets/botoes_acao.dart';
import '../widgets/resultado_popup.dart';

class PublicScreen extends StatefulWidget {
  const PublicScreen({super.key});

  @override
  State<PublicScreen> createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  final GlobalKey _globalKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();

  int numero = 0;
  int maxNumero = 0;

  bool podeSortear = false;
  bool _isAnimating = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _definirNumero(String value) {
    final parsed = int.tryParse(value);

    setState(() {
      if (parsed != null && parsed > 0 && parsed <= 100000) {
        maxNumero = parsed;
        podeSortear = true;
      } else {
        podeSortear = false;
      }
    });
  }

  void sortear() {
    if (_isAnimating || !podeSortear) return;

    setState(() => _isAnimating = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        numero = Random().nextInt(maxNumero) + 1;
      });

      _confettiController.play();

      Future.delayed(_confettiController.duration, () {
        setState(() => _isAnimating = false);
        mostrarResultado();
      });
    });
  }

  void mostrarResultado() {
    final agora = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => ResultadoPopup(
        numero: numero,
        agora: agora,
        globalKey: _globalKey,
      ),
    );
  }

  void _resetTudo() {
    setState(() {
      numero = 0;
      maxNumero = 0;
      podeSortear = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: HeaderApp(maxNumero: maxNumero),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isAnimating,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InputNumero(
                      controller: _controller,
                      onChanged: _definirNumero,
                    ),
                    Expanded(
                      child: Center(
                        child: NumeroDisplay(numero: numero),
                      ),
                    ),
                    BotoesAcao(
                      podeSortear: podeSortear,
                      isAnimating: _isAnimating,
                      onSortear: sortear,
                      onReset: _resetTudo,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: math.pi / 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
