import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/public_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PublicScreen(),
    );
  }
}









// import 'dart:math' as math;
// import 'dart:math';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:confetti/confetti.dart';
// import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flip PRO',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const PublicScreen(),
//     );
//   }
// }

// class PublicScreen extends StatefulWidget {
//   const PublicScreen({super.key});

//   @override
//   State<PublicScreen> createState() => _PublicScreenState();
// }

// class _PublicScreenState extends State<PublicScreen> {
//   final GlobalKey _globalKey = GlobalKey();
//   final TextEditingController _controller = TextEditingController();

//   int numero = 0;
//   int maxNumero = 0;

//   bool podeSortear = false;
//   bool _isAnimating = false;

//   late ConfettiController _confettiController;

//   @override
//   void initState() {
//     super.initState();
//     _confettiController =
//         ConfettiController(duration: const Duration(seconds: 2));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _confettiController.dispose();
//     super.dispose();
//   }

//   void _definirNumero(String value) {
//     final parsed = int.tryParse(value);

//     if (parsed != null && parsed > 0 && parsed <= 100000) {
//       setState(() {
//         maxNumero = parsed;
//         podeSortear = true;
//       });
//     } else {
//       setState(() {
//         podeSortear = false;
//       });
//     }
//   }

//   void sortear() {
//     if (!podeSortear) return;

//     setState(() {
//       _isAnimating = true;
//     });

//     Future.delayed(const Duration(milliseconds: 800), () {
//       setState(() {
//         numero = Random().nextInt(maxNumero) + 1;
//         _isAnimating = false;
//       });

//       _confettiController.play();

//       mostrarResultado(); // 👈 AQUI
//     });
//   }

//   void _resetTudo() {
//     setState(() {
//       numero = 0;
//       maxNumero = 0;
//       podeSortear = false;
//       _controller.clear();
//     });
//   }

//   Future<void> salvarResultado() async {
//     try {
//       // 🔐 Permissão (Android 13+ usa photos)
//       var status = await Permission.photos.request();

//       if (!status.isGranted) {
//         status = await Permission.storage.request();
//       }

//       if (!status.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Permissão negada!')),
//         );
//         return;
//       }

//       // 📸 Captura da tela do popup
//       RenderRepaintBoundary boundary = _globalKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;

//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);

//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);

//       final bytes = byteData!.buffer.asUint8List();

//       // 💾 Salvar imagem
//       final result = await ImageGallerySaverPlus.saveImage(
//         bytes,
//         quality: 100,
//         name: "sorteio_${DateTime.now().millisecondsSinceEpoch}",
//       );

//       if (result['isSuccess'] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Imagem salva na galeria! 📸')),
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void mostrarResultado() {
//     final agora = DateTime.now();

//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               RepaintBoundary(
//                   child: Container(
//                 margin: const EdgeInsets.only(top: 40),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     RepaintBoundary(
//                       key: _globalKey,
//                       child: Container(
//                         width: 400,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           children: [
//                             const Text(
//                               '🎉 Numero Sorteado:',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               numero.toString(),
//                               style: const TextStyle(
//                                 fontSize: 60,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               'Data: ${agora.day}/${agora.month}/${agora.year}',
//                             ),
//                             Text(
//                               'Hora: ${agora.hour}:${agora.minute.toString().padLeft(2, '0')}',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Fechar'),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       onPressed: salvarResultado,
//                       icon: const Icon(Icons.save),
//                       label: const Text('Salvar resultado'),
//                     ),
//                   ],
//                 ),
//               )),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(130),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               color: const Color.fromARGB(255, 105, 228, 113),
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 10,
//                 left: 20,
//                 right: 20,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     maxNumero > 0
//                         ? '🎰 Sorteador 1-$maxNumero'
//                         : '🎰 Sorteador',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Icon(
//                     Icons.person_outline,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/fundo.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Text(
//                             '📝 Número máximo:',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.orange[700],
//                             ),
//                           ),
//                           const SizedBox(height: 15),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Card(
//                                   child: TextField(
//                                     controller: _controller,
//                                     onChanged: _definirNumero,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.digitsOnly,
//                                     ],
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       labelText: 'Ex: 100, 250..',
//                                       prefixText: '1 a ',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 50),

//                     // 🔢 DISPLAY
//                     Container(
//                       width: 200,
//                       height: 200,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: const [
//                           BoxShadow(
//                             blurRadius: 25,
//                             color: Colors.black26,
//                           )
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           numero.toString(),
//                           style: const TextStyle(
//                             fontSize: 90,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 60),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: podeSortear ? sortear : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepOrange,
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: Text(
//                           _isAnimating
//                               ? '🎡 Sorteando...'
//                               : podeSortear
//                                   ? '🎰 SORTEAR!'
//                                   : 'Defina o Número primeiro',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             color: Color.fromARGB(255, 31, 30, 30),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     TextButton.icon(
//                       onPressed: _resetTudo,
//                       icon: const Icon(Icons.refresh, color: Colors.white),
//                       label: const Text(
//                         'Novo Sorteio',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // 🎉 CONFETE
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: ConfettiWidget(
//                   confettiController: _confettiController,
//                   blastDirection: math.pi / 2,
//                   emissionFrequency: 0.05,
//                   numberOfParticles: 50,
//                   gravity: 0.1,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
