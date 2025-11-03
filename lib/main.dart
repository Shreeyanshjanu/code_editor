// ignore_for_file: unused_import
import 'package:code_editor/pages/compiler_page.dart';
import 'package:code_editor/pages/login_page.dart';
import 'package:code_editor/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CompilerPage(),
    );
  }
}
