import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(context, appState),
          Expanded(
            child: Column(
              children: [
                _buildHeaderBar(context, appState, isDesktop),
                Expanded(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildMobileBottomNav(context, appState),
    );
  }

  Widget _buildSidebar(BuildContext context, AppState appState) {
    final isDark = appState.isDarkMode;

    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.darkSurfaceContainer : AppColors.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Logo & Brand Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.explore_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CareerPilot AI',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Career Accelerator',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 11,
                              color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildNavItem(context, appState, index: 0, icon: Icons.dashboard_rounded, label: 'Dashboard'),
                _buildNavItem(context, appState, index: 1, icon: Icons.map_rounded, label: 'Career Roadmap'),
                _buildNavItem(context, appState, index: 2, icon: Icons.track_changes_rounded, label: 'Skill Gap Analysis'),
                _buildNavItem(context, appState, index: 3, icon: Icons.memory_rounded, label: 'Skills & Stack'),
                _buildNavItem(context, appState, index: 4, icon: Icons.description_rounded, label: 'Resume Intelligence'),
                _buildNavItem(context, appState, index: 5, icon: Icons.code_rounded, label: 'Project Recommendations'),
                _buildNavItem(context, appState, index: 6, icon: Icons.mic_rounded, label: 'AI Mock Interview'),
                _buildNavItem(context, appState, index: 7, icon: Icons.show_chart_rounded, label: 'Progress & Analytics'),
                const Divider(height: 32, indent: 8, endIndent: 8),
                _buildNavItem(context, appState, index: 8, icon: Icons.person_rounded, label: 'My Profile'),
                _buildNavItem(context, appState, index: 9, icon: Icons.settings_rounded, label: 'Settings'),
              ],
            ),
          ),

          // Footer / Dark Mode Toggle
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          size: 18,
                          color: isDark ? Colors.amber : AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            isDark ? 'Dark Mode' : 'Light Mode',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (_) => appState.toggleTheme(),
                    activeThumbColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    AppState appState, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = appState.currentScreenIndex == index;
    final isDark = appState.isDarkMode;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => appState.setScreenIndex(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark ? AppColors.primaryContainer : AppColors.surfaceContainer)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.darkOnSurface : AppColors.onSurface),
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context, AppState appState, bool isDesktop) {
    final profile = appState.userProfile;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: appState.isDarkMode ? AppColors.darkSurface : AppColors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: appState.isDarkMode ? AppColors.darkSurfaceContainer : AppColors.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isDesktop) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.explore_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'CareerPilot AI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            Expanded(
              child: Text(
                _getScreenTitle(appState.currentScreenIndex),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const SizedBox(width: 8),

          // Target Role Badge (Desktop only)
          if (isDesktop) ...[
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.track_changes_rounded, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        profile.targetRole,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // User Profile Quick Avatar
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => appState.setScreenIndex(8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: Text('AS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Readiness: ${profile.readinessScore}%',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 11,
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomNav(BuildContext context, AppState appState) {
    return NavigationBar(
      selectedIndex: appState.currentScreenIndex > 4 ? 0 : appState.currentScreenIndex,
      onDestinationSelected: (idx) => appState.setScreenIndex(idx),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.map_rounded), label: 'Roadmap'),
        NavigationDestination(icon: Icon(Icons.track_changes_rounded), label: 'Skill Gap'),
        NavigationDestination(icon: Icon(Icons.description_rounded), label: 'Resume'),
        NavigationDestination(icon: Icon(Icons.mic_rounded), label: 'Interview'),
      ],
    );
  }

  String _getScreenTitle(int index) {
    switch (index) {
      case 0:
        return 'Career Readiness Dashboard';
      case 1:
        return 'Career Roadmap';
      case 2:
        return 'Skill Gap Analysis';
      case 3:
        return 'Skills & Tech Stack';
      case 4:
        return 'Resume Intelligence';
      case 5:
        return 'Project Recommendations';
      case 6:
        return 'AI Mock Interview';
      case 7:
        return 'Progress & Analytics';
      case 8:
        return 'My Profile';
      case 9:
        return 'Settings';
      default:
        return 'CareerPilot AI';
    }
  }
}
