import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_file/widgets/app_bar.dart';

class ImagePage extends StatelessWidget {
  final File imageFile;

  const ImagePage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(text: 'Visonneur d\'image'),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
