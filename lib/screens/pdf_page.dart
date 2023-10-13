import 'dart:io';
import 'package:gestion_file/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFPage extends StatelessWidget {
  final File pdfFilePath;

  const PDFPage({super.key, required this.pdfFilePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(text: 'Lecteur de PDF'),
      body: _buildPdfPages(pdfFilePath),
    );
  }

  Widget _buildPdfPages(File pdfFilePath) {
    return Center(
      child: PDFView(
        filePath: pdfFilePath.path,
      ),
    );
  }
}
