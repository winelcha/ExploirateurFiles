import 'dart:io';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  final File textFile;

  TextPage({required this.textFile});

  @override
  Widget build(BuildContext context) {
    final textContent = textFile.readAsStringSync();

    return Scaffold(
         backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Lecture de texte'),
      ),
      body: SingleChildScrollView(
        child: Text(textContent),
      ),
    );
  }
}
