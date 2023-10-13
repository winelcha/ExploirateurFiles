import 'dart:io';
import 'package:exploirateurfile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final File imageFile;

  ImagePage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appbar(text: 'Image'),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
