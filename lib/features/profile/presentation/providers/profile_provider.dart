import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/profile_model.dart';
import '../../data/profile_service.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

part 'profile_provider.g.dart';

@riverpod
ProfileService profileService(ProfileServiceRef ref) {
  return ProfileService();
}

@riverpod
Stream<Profile?> userProfile(UserProfileRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return Stream.value(null);
  }
  return ref.watch(profileServiceProvider).streamProfile(user.id);
}
