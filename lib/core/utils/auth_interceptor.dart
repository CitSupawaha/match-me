import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/widgets/login_bottom_sheet.dart';

/// Wraps an action that requires authentication.
/// If the user is logged in, the action is executed immediately.
/// If the user is a guest, the LoginBottomSheet is shown.
void runWithAuth(BuildContext context, WidgetRef ref, VoidCallback action) {
  final user = ref.read(currentUserProvider);
  
  if (user != null) {
    // User is logged in, execute the action
    action();
  } else {
    // User is a guest, show the login prompt
    LoginBottomSheet.show(context);
  }
}
