import 'package:flutter/material.dart';

PreferredSizeWidget?  appbar({String? text}) {
  return AppBar(
    backgroundColor: Colors.blueAccent.withOpacity(0.6),
    title: Text(
     text!,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
