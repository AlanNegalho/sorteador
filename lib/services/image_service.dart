import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class ImageService {
  static Future<void> salvar(GlobalKey key, BuildContext context) async {
    try {
      var status = await Permission.photos.request();

      if (!status.isGranted) {
        status = await Permission.storage.request();
      }

      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão negada!')),
        );
        return;
      }

      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final bytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        quality: 100,
        name: "sorteio_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (result['isSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imagem salva! 📸')),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
