import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final profile = appState.userProfile;
    final isMobile = MediaQuery.of(context).size.width < 800;

    final profileHeaderContent = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (!isMobile) ...[
              ElevatedButton.icon(
                onPressed: () => _showEditProfileModal(context, appState),
                icon: const Icon(Icons.edit_rounded, size: 16),
                label: const Text('Edit Profile'),
              ),
            ],
          ],
        ),
        Text(
          profile.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          profile.bio,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 8,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_rounded, size: 14, color: AppColors.outline),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    profile.location,
                    style: const TextStyle(fontSize: 12, color: AppColors.outline),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.email_rounded, size: 14, color: AppColors.outline),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    profile.email,
                    style: const TextStyle(fontSize: 12, color: AppColors.outline),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showEditProfileModal(context, appState),
            icon: const Icon(Icons.edit_rounded, size: 16),
            label: const Text('Edit Profile'),
          ),
        ],
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: isMobile
                  ? Column(
                      children: [
                        const CircleAvatar(
                          radius: 44,
                          backgroundColor: AppColors.primary,
                          child: Text('AS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                        ),
                        const SizedBox(height: 16),
                        profileHeaderContent,
                      ],
                    )
                  : Row(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          child: Text('AS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32)),
                        ),
                        const SizedBox(width: 24),
                        Expanded(child: profileHeaderContent),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // Education & Experience
          if (isMobile) ...[
            _buildEducationCard(context),
            const SizedBox(height: 24),
            _buildPreferencesCard(context, profile),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildEducationCard(context)),
                const SizedBox(width: 24),
                Expanded(child: _buildPreferencesCard(context, profile)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Education & Certifications', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTimelineItem(context, 'B.S. Computer Science (AI Track)', 'Stanford University • 2023 - 2026', 'GPA: 3.9/4.0 • Coursework: Deep Learning, Computer Vision, Distributed Systems.'),
            const SizedBox(height: 12),
            _buildTimelineItem(context, 'Deep Learning Specialization', 'Coursera / DeepLearning.AI', '5-course series covering Neural Networks, Hyperparameter Tuning, CNNs, and Sequence Models.'),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context, profile) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Target Role Preferences', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPreferenceItem('Primary Target', profile.targetRole),
            const SizedBox(height: 10),
            _buildPreferenceItem('Desired Industry', 'AI / ML SaaS & Cloud'),
            const SizedBox(height: 10),
            _buildPreferenceItem('Work Type', 'Hybrid / Remote'),
            const SizedBox(height: 10),
            _buildPreferenceItem('Expected Readiness Date', 'December 2026'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String title, String sub, String desc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(sub, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.outline), overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 8),
        Flexible(child: Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  void _showEditProfileModal(BuildContext context, AppState appState) {
    final nameCtrl = TextEditingController(text: appState.userProfile.name);
    final titleCtrl = TextEditingController(text: appState.userProfile.title);
    final targetCtrl = TextEditingController(text: appState.userProfile.targetRole);
    final bioCtrl = TextEditingController(text: appState.userProfile.bio);
    final locationCtrl = TextEditingController(text: appState.userProfile.location);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full Name')),
                const SizedBox(height: 12),
                TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Current Title')),
                const SizedBox(height: 12),
                TextField(controller: targetCtrl, decoration: const InputDecoration(labelText: 'Target Role')),
                const SizedBox(height: 12),
                TextField(controller: bioCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Short Bio')),
                const SizedBox(height: 12),
                TextField(controller: locationCtrl, decoration: const InputDecoration(labelText: 'Location')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                appState.updateUserProfile(
                  name: nameCtrl.text,
                  title: titleCtrl.text,
                  targetRole: targetCtrl.text,
                  bio: bioCtrl.text,
                  location: locationCtrl.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }
}
