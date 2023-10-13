// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:exploirateurfile/screens/folder_page.dart';
import 'package:exploirateurfile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
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
  List<String> folderHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  Future<void> _getStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      _loadFiles('/storage/emulated/0');
    } else {}
  }

  void _loadFiles(String folderPath) {
    final folder = Directory(folderPath);
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
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
        backgroundColor: Colors.black,
        appBar: appbar(text:'Mon explorateur de fichiers'),
        body:isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Indicateur de chargement
            )
          : ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final entity = files[index]; //
            return ListTile(
                leading: Icon(
                    entity is Directory ? Icons.folder : Icons.file_copy,
                    color: Colors.tealAccent),
                title: Text(
                  entity.path.split('/').last,
                  style: const TextStyle(color: Colors.white),
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
                  } else {}
                });
          },
        ),
      ),
    );
  }
}
