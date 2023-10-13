import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_file/screens/audois_page.dart';
import 'package:gestion_file/screens/folder_page.dart';
import 'package:gestion_file/screens/image_page.dart';
import 'package:gestion_file/screens/pdf_page.dart';
import 'package:gestion_file/screens/videos_page.dart';
import 'package:gestion_file/widgets/app_bar.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<FileSystemEntity> files = [];

  bool isLoading = true;

  @override
  void initState() {
    _getStoragePermission();
    super.initState();
  }

  Future<void> _getStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    _loadFiles('/storage/emulated/0/');
  }

  void _loadFiles(String folderPath) {
    Directory folder = Directory(folderPath);

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        files = folder.listSync();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(text: 'explorateur de fichiers'),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final entity = files[index];
                  return ListTile(
                      leading: Icon(
                          entity is Directory
                              ? Icons.folder
                              : Icons.file_present_sharp,
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
                              builder: (context) =>
                                  FolderPage(folderPath: entity.path),
                            ),
                          );
                        } else {
                          if (entity.path.endsWith('.jpg') ||
                              entity.path.endsWith('.jpeg') ||
                              entity.path.endsWith('.png')) {
                            final imageFile = File(entity.path);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImagePage(imageFile: imageFile),
                              ),
                            );
                          } else if (entity.path.endsWith('.m4a') ||
                              entity.path.endsWith('.aac') ||
                              entity.path.endsWith('.mp3') ||
                              entity.path.endsWith('.wav') ||
                              entity.path.endsWith('.opus')) {
                            final audioFile = File(entity.path);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioPlayerPage(
                                    audioFilePath: audioFile.path),
                              ),
                            );
                          } else if (entity.path.endsWith('.mp4') ||
                              entity.path.endsWith('.avi')) {
                            final videoFile = File(entity.path);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerPage(
                                    videoFilePath: videoFile.path),
                              ),
                            );
                          } else {
                            if (entity.path.endsWith('.pdf')) {
                              final pdfFile = File(entity.path);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFPage(
                                    pdfFilePath: pdfFile,
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      });
                },
              ),
      ),
    );
  }
}
