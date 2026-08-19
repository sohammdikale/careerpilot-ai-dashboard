import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final profile = appState.userProfile;
    final isMobile = MediaQuery.of(context).size.width < 850;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner / Hero Card
          _buildHeroBanner(context, appState),
          const SizedBox(height: 24),

          // 4 Metric Summary Cards
          _buildMetricsGrid(context, profile),
          const SizedBox(height: 32),

          // Recommended Focus Actions & Recent Activity
          if (isMobile) ...[
            _buildRecommendedActions(context, appState),
            const SizedBox(height: 24),
            _buildRecentActivity(context),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildRecommendedActions(context, appState),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: _buildRecentActivity(context),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, AppState appState) {
    final profile = appState.userProfile;

    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '⚡ AI Readiness Engine Active',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: appState.isBackendConnected ? const Color(0xFF10B981) : Colors.amber.shade800,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    appState.isBackendConnected ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    appState.isBackendConnected ? 'Backend Live' : 'Offline Mode',
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Welcome back, ${profile.name.split(' ').first}! 👋',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'You are 84% ready for your target role as ${profile.targetRole}. Complete 2 suggested actions to reach 90% readiness!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => appState.setScreenIndex(1),
          icon: const Icon(Icons.arrow_forward_rounded, size: 18),
          label: const Text('Continue Roadmap'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
          ),
        ),
      ],
    );

    final scoreGauge = Container(
      width: 110,
      height: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 85,
              height: 85,
              child: CircularProgressIndicator(
                value: profile.readinessScore / 100,
                strokeWidth: 8,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${profile.readinessScore}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Readiness',
                  style: TextStyle(fontSize: 9, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 650;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryContainer,
                AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textContent,
                    const SizedBox(height: 20),
                    Center(child: scoreGauge),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: textContent),
                    const SizedBox(width: 20),
                    scoreGauge,
                  ],
                ),
        );
      },
    );
  }

  Widget _buildMetricsGrid(BuildContext context, profile) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 450 ? 2 : 1);
      return GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.6,
        children: [
          _buildMetricCard(
            context,
            title: 'Skill Match Ratio',
            value: '84%',
            subtitle: '6 of 7 Required Skills',
            icon: Icons.track_changes_rounded,
            color: AppColors.primary,
          ),
          _buildMetricCard(
            context,
            title: 'Roadmap Progress',
            value: '8 / 12',
            subtitle: 'Milestones Completed',
            icon: Icons.map_rounded,
            color: AppColors.secondary,
          ),
          _buildMetricCard(
            context,
            title: 'ATS Resume Score',
            value: '84 / 100',
            subtitle: 'Top 10% Candidate',
            icon: Icons.description_rounded,
            color: AppColors.success,
          ),
          _buildMetricCard(
            context,
            title: 'Mock Interview Rating',
            value: '88%',
            subtitle: 'Technical & Behavioral',
            icon: Icons.mic_rounded,
            color: AppColors.warning,
          ),
        ],
      );
    });
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11,
                        color: AppColors.outline,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedActions(BuildContext context, AppState appState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'AI Recommended Focus',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () => appState.setScreenIndex(2),
                  child: const Text('View All Gaps'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFocusTile(
              context,
              title: 'Learn Kubernetes & Kubeflow Basics',
              category: 'Skill Gap',
              impact: '+6% Readiness',
              icon: Icons.memory_rounded,
              onTap: () => appState.setScreenIndex(2),
            ),
            const SizedBox(height: 12),
            _buildFocusTile(
              context,
              title: 'Add ONNX Latency Metrics to Resume',
              category: 'Resume Boost',
              impact: '+3% ATS Score',
              icon: Icons.description_rounded,
              onTap: () => appState.setScreenIndex(4),
            ),
            const SizedBox(height: 12),
            _buildFocusTile(
              context,
              title: 'Practice Transformer Self-Attention Session',
              category: 'Mock Interview',
              impact: '+4% Interview Score',
              icon: Icons.mic_rounded,
              onTap: () => appState.setScreenIndex(6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusTile(
    BuildContext context, {
    required String title,
    required String category,
    required String impact,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    impact,
                    style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              context,
              title: 'Completed PyTorch Deep Learning Milestone',
              time: '2 hours ago',
              icon: Icons.check_circle_rounded,
              color: AppColors.success,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              context,
              title: 'Scored 88% on Deep Learning Interview',
              time: 'Yesterday',
              icon: Icons.workspace_premium_rounded,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              context,
              title: 'Uploaded Resume v2.4 for ATS Scan',
              time: '3 days ago',
              icon: Icons.cloud_upload_rounded,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context, {
    required String title,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 11,
                      color: AppColors.outline,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
