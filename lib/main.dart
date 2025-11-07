import 'package:code_editor/pages/compiler_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:code_editor/API_keys/supabase_keys.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseKeys.supabaseUrl,
    anonKey: SupabaseKeys.supabaseAnonKey,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CompilerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
