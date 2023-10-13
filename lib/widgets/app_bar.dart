import 'package:flutter/material.dart';

PreferredSizeWidget?  appbar({String? text}) {
  return AppBar(
    backgroundColor: Colors.grey.withOpacity(0.6),
    title: Text(
     text!,
      style: TextStyle(color: Colors.white),
    ),
  );
}
