import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_me/core/widgets/app_bottom_nav.dart';
import 'package:match_me/features/home/presentation/pages/home_screen.dart';
import 'package:match_me/features/match/presentation/pages/explore_matches_screen.dart';

/// Provider to manage the current tab index across the app.
final currentTabProvider = StateProvider<int>((ref) => 0);

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static const _tabs = [
    NavTab.home,
    NavTab.match,
    NavTab.host,
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
          // Host placeholder
          const _PlaceholderTab(title: 'Host'),
          // Profile placeholder
          const _PlaceholderTab(title: 'Profile'),
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

/// Placeholder widget for tabs not yet implemented.
class _PlaceholderTab extends StatelessWidget {
  final String title;
  const _PlaceholderTab({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
