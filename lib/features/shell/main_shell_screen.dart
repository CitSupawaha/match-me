import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_me/core/widgets/app_bottom_nav.dart';
import 'package:match_me/features/home/presentation/pages/home_screen.dart';
import 'package:match_me/features/match/presentation/pages/explore_matches_screen.dart';
import 'package:match_me/features/notification/presentation/pages/notification_screen.dart';
import 'package:match_me/features/profile/presentation/pages/profile_screen.dart';

/// Provider to manage the current tab index across the app.
final currentTabProvider = StateProvider<int>((ref) => 0);

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static const _tabs = [
    NavTab.home,
    NavTab.match,
    NavTab.notifications,
    NavTab.profile,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const HomeScreen(),
          const ExploreMatchesScreen(),
          const NotificationScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        activeTab: _tabs[currentIndex],
        onTabChanged: (tab) {
          ref.read(currentTabProvider.notifier).state = _tabs.indexOf(tab);
        },
      ),
      extendBody: true,
    );
  }
}

