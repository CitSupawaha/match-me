import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/auth_service.dart';

part 'auth_provider.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

@riverpod
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authServiceProvider).authStateChanges;
}

@riverpod
User? currentUser(CurrentUserRef ref) {
  final authStateAsync = ref.watch(authStateChangesProvider);
  return authStateAsync.maybeWhen(
    data: (state) => state.session?.user,
    orElse: () => ref.watch(authServiceProvider).currentUser,
  );
}
