import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class SkillGapAnalysisScreen extends StatelessWidget {
  const SkillGapAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final targetRole = appState.selectedTargetRole;
    final skills = appState.skills;
    final gapSkills = skills.where((s) => s.status == 'Skill Gap').toList();
    final masteredSkills = skills.where((s) => s.status == 'Mastered').toList();
    final inProgressSkills = skills.where((s) => s.status == 'In Progress').toList();
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Role Selection Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Role Analysis',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.outline,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              targetRole,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                              onSelected: (role) => appState.setTargetRole(role),
                              itemBuilder: (context) => const [
                                PopupMenuItem(value: 'Machine Learning Engineer', child: Text('Machine Learning Engineer')),
                                PopupMenuItem(value: 'Full Stack Developer', child: Text('Full Stack Developer')),
                                PopupMenuItem(value: 'Data Scientist', child: Text('Data Scientist')),
                                PopupMenuItem(value: 'DevOps / MLOps Engineer', child: Text('DevOps / MLOps Engineer')),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'AI-analyzed market demand based on 4,200+ active job postings across top technology companies.',
                          style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text('Target Match', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                        Text(
                          '84%',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Skill Gap Breakdown Cards
          if (isMobile) ...[
            _buildCriticalGapsCard(context, appState, gapSkills),
            const SizedBox(height: 24),
            _buildActiveSkillsCard(context, masteredSkills, inProgressSkills),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCriticalGapsCard(context, appState, gapSkills)),
                const SizedBox(width: 24),
                Expanded(child: _buildActiveSkillsCard(context, masteredSkills, inProgressSkills)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCriticalGapsCard(BuildContext context, AppState appState, List gapSkills) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Critical Skill Gaps (${gapSkills.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...gapSkills.map((s) => _buildGapTile(context, appState, s)),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSkillsCard(BuildContext context, List masteredSkills, List inProgressSkills) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: AppColors.success, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Mastered & Active Skills (${masteredSkills.length + inProgressSkills.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...masteredSkills.map((s) => _buildSkillProgressTile(context, s)),
            ...inProgressSkills.map((s) => _buildSkillProgressTile(context, s)),
          ],
        ),
      ),
    );
  }

  Widget _buildGapTile(BuildContext context, AppState appState, s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.errorContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  s.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('High Priority', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Category: ${s.category} • Current Level: ${(s.proficiency * 100).toInt()}%',
            style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              appState.updateSkillProficiency(s.id, 0.6);
            },
            icon: const Icon(Icons.add_circle_outline_rounded, size: 14),
            label: const Text('Start Learning Path'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillProgressTile(BuildContext context, s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  s.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${(s.proficiency * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: s.proficiency,
              minHeight: 6,
              backgroundColor: AppColors.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(
                s.proficiency >= 0.8 ? AppColors.success : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
