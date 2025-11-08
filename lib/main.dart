import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:code_editor/pages/login_page.dart';
import 'package:code_editor/pages/reset_password_page.dart';
import 'package:code_editor/pages/compiler_page.dart';
import 'package:code_editor/API_keys/supabase_keys.dart';
import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseKeys.supabaseUrl,
    anonKey: SupabaseKeys.supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _checkedInitialRoute = false;
  bool _isResettingPassword = false; // Flag to track password reset flow

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
    _checkForPasswordRecovery();
  }

  /// Check if URL contains password recovery parameters
  void _checkForPasswordRecovery() {
    // Check URL hash for recovery token
    final hash = html.window.location.hash;
    final params = Uri.parse('?$hash').queryParameters;
    
    print('🔍 URL Hash: $hash');
    print('🔍 Query Params: $params');
    
    // Check if this is a password recovery link
    if (hash.contains('type=recovery') || params['type'] == 'recovery') {
      print('✅ Password recovery detected in URL');
      _isResettingPassword = true; // Set flag when entering reset flow
      
      // Navigate to reset password page after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResetPasswordPage(),
          ),
        );
      });
    }
    
    setState(() {
      _checkedInitialRoute = true;
    });
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      
      print('🔔 Auth State Change: $event');

      // Handle different auth events
      if (event == AuthChangeEvent.passwordRecovery) {
        print('✅ Password recovery event');
        _isResettingPassword = true; // Set flag on password recovery
        _navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResetPasswordPage(),
          ),
        );
      } else if (event == AuthChangeEvent.signedIn && _checkedInitialRoute) {
        // IMPORTANT: Skip navigation if we're in the password reset flow
        // This prevents the automatic redirect when updateUser() triggers signedIn event
        if (_isResettingPassword) {
          print('⏭️ Skipping navigation - password reset in progress');
          return;
        }
        
        // Check if this is a recovery sign-in by checking URL
        final hash = html.window.location.hash;
        if (hash.contains('type=recovery')) {
          print('✅ Sign-in detected with recovery type');
          _isResettingPassword = true; // Set flag
          _navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ResetPasswordPage(),
            ),
          );
        } else {
          // Regular sign-in - go to compiler
          final user = Supabase.instance.client.auth.currentUser;
          if (user != null) {
            print('✅ User logged in: ${user.email}');
            _navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const CompilerPage(),
              ),
            );
          }
        }
      } else if (event == AuthChangeEvent.signedOut) {
        // Reset the flag when user signs out
        print('🔓 User signed out, resetting password reset flag');
        _isResettingPassword = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Code Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
