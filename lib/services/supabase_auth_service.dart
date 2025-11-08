import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign up with email and password
  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username}, // Store username in metadata
      );

      if (response.user != null) {
        return {
          'success': true,
          'user': response.user,
          'message': 'Signup successful! Please check your email to verify.',
        };
      } else {
        return {'success': false, 'error': 'Signup failed'};
      }
    } on AuthException catch (e) {
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': 'An error occurred: $e'};
    }
  }

  /// Login with email and password
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return {
          'success': true,
          'user': response.user,
          'session': response.session,
        };
      } else {
        return {'success': false, 'error': 'Login failed'};
      }
    } on AuthException catch (e) {
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': 'An error occurred: $e'};
    }
  }

  /// Logout
  static Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  /// Get current user
  static User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  /// Get current session
  static Session? getCurrentSession() {
    return _supabase.auth.currentSession;
  }

  /// Password reset
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
  }) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return {
        'success': true,
        'message': 'Password reset email sent! Check your inbox.',
      };
    } on AuthException catch (e) {
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': 'An error occurred: $e'};
    }
  }

  /// Update password (after reset email link)
  static Future<Map<String, dynamic>> updatePassword({
    required String newPassword,
  }) async {
    try {
      print('📤 Updating password...');

      final response = await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      print('📥 Password update response: ${response.user?.id}');

      if (response.user != null) {
        return {'success': true, 'message': 'Password updated successfully'};
      } else {
        return {'success': false, 'error': 'Failed to update password'};
      }
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      return {'success': false, 'error': e.message};
    } catch (e) {
      print('❌ Error: $e');
      return {'success': false, 'error': 'An error occurred: $e'};
    }
  }
}
