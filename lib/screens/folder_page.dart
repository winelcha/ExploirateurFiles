import 'dart:io';
import 'package:exploirateurfile/screens/audois_page.dart';
import 'package:exploirateurfile/screens/image_page.dart';
// import 'package:exploirateurfile/screens/pdf_page.dart';
import 'package:exploirateurfile/screens/text_page.dart';
import 'package:exploirateurfile/screens/videos_page.dart';
import 'package:exploirateurfile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final String folderPath;

  FolderPage({required this.folderPath});

  @override
  Widget build(BuildContext context) {
    final directory = Directory(folderPath);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appbar(text: 'Contenu du répertoire'),
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
            entity is Directory ? Icons.folder : Icons.file_copy,
            color: Colors.tealAccent,
          ),
          title: Text(
            entity.path.split('/').last,
            style: const TextStyle(color: Colors.white),
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
                    builder: (context) => TextPage(
                      textFile: pdfFile,
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
                  filePath.endsWith('.wav')) {
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
