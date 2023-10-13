import 'dart:io';
import 'package:gestion_file/screens/audois_page.dart';
import 'package:gestion_file/screens/image_page.dart';
import 'package:gestion_file/screens/pdf_page.dart';
import 'package:gestion_file/screens/text_page.dart';
import 'package:gestion_file/screens/videos_page.dart';
import 'package:gestion_file/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final String folderPath;

  const FolderPage({super.key, required this.folderPath});

  @override
  Widget build(BuildContext context) {
    final directory = Directory(folderPath);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(text: 'explorateur de fichiers'),
      body: _buildFolderContent(directory),
    );
  }

  Widget _buildFolderContent(Directory directory) {
    final entities = directory.listSync();

    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (context, index) {
        final entity = entities[index];
        return ListTile(
          leading: Icon(
              entity is Directory ? Icons.folder : Icons.file_present_sharp,
              color: Colors.blue),
          title: Text(
            entity.path.split('/').last,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            if (entity is Directory) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FolderPage(folderPath: entity.path),
                ),
              );
            } else {
              final filePath = entity.path.toLowerCase();

              if (filePath.endsWith('.jpg') ||
                  filePath.endsWith('.jpeg') ||
                  filePath.endsWith('.png')) {
                final imageFile = File(entity.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePage(imageFile: imageFile),
                  ),
                );
              } else if (filePath.endsWith('.pdf')) {
                final pdfFile = File(entity.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFPage(
                      pdfFilePath: pdfFile,
                    ),
                  ),
                );
              } else if (filePath.endsWith('.txt') ||
                  filePath.endsWith('.pdf') ||
                  filePath.endsWith('.doc')) {
                final textFile = File(entity.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextPage(textFile: textFile),
                  ),
                );
              } else if (filePath.endsWith('.m4a') ||
                  filePath.endsWith('.aac') ||
                  filePath.endsWith('.mp3') ||
                  filePath.endsWith('.wav') ||
                  entity.path.endsWith('.opus')) {
                final audioFile = File(entity.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AudioPlayerPage(audioFilePath: audioFile.path),
                  ),
                );
              } else if (filePath.endsWith('.mp4') ||
                  filePath.endsWith('.avi')) {
                final videoFile = File(entity.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerPage(videoFilePath: videoFile.path),
                  ),
                );
              } else {}
            }
          },
        );
      },
    );
  }
}
