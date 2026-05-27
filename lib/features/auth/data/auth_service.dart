import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Stream of auth state changes
  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  // Get current user
  User? get currentUser => _supabaseClient.auth.currentUser;

  // Sign in with Google (OAuth)
  Future<void> signInWithGoogle() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.matchme://login-callback',
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
  }

  // Sign in with Apple (OAuth)
  Future<void> signInWithApple() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.matchme://login-callback',
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
  }

  // Sign in with Facebook (OAuth)
  Future<void> signInWithFacebook() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: 'io.supabase.matchme://login-callback',
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
  }

  // Sign in with Email
  Future<void> signInWithEmail(String email, String password) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with Email
  Future<void> signUpWithEmail(String email, String password) async {
    await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
