import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class ResumeIntelligenceScreen extends StatelessWidget {
  const ResumeIntelligenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final resume = appState.resumeAnalysis;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card with ATS Score
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.successContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '✨ Top 10% ATS Candidate Match',
                            style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Resume Intelligence & ATS Analyzer',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'AI-scanned against target role: ${appState.selectedTargetRole}. Scanned version: resume_alex_v2.4.pdf',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${resume.overallAtsScore}',
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                          const Text('ATS SCORE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.outline)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 4 Score Pillars Grid
          LayoutBuilder(builder: (context, constraints) {
            final cols = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 400 ? 2 : 1);
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: cols == 1 ? 2.5 : 1.6,
              children: [
                _buildScorePillar(context, 'Impact Score', '${resume.impactScore}%', Icons.flash_on_rounded, AppColors.primary),
                _buildScorePillar(context, 'Keyword Match', '${resume.keywordMatchScore}%', Icons.search_rounded, AppColors.secondary),
                _buildScorePillar(context, 'Formatting', '${resume.formatScore}%', Icons.view_quilt_rounded, AppColors.success),
                _buildScorePillar(context, 'Structure', '${resume.structureScore}%', Icons.check_box_rounded, AppColors.warning),
              ],
            );
          }),
          const SizedBox(height: 32),

          // Upload Dropzone & AI Suggestions Section
          if (isMobile) ...[
            _buildUploadCard(context),
            const SizedBox(height: 24),
            _buildSuggestionsCard(context, appState, resume),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildUploadCard(context)),
                const SizedBox(width: 24),
                Expanded(flex: 3, child: _buildSuggestionsCard(context, appState, resume)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.solid, width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload_rounded, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Upload Updated Resume',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Drag & drop your PDF file here, or click to browse', style: TextStyle(fontSize: 12, color: AppColors.outline), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulated Resume PDF Upload & AI Scan completed!')),
                      );
                    },
                    icon: const Icon(Icons.post_add_rounded, size: 16),
                    label: const Text('Select PDF File'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsCard(BuildContext context, AppState appState, resume) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'AI Improvement Suggestions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${resume.suggestions.where((s) => !s.isApplied).length} Action Items',
                    style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...resume.suggestions.map((s) => _buildSuggestionTile(context, appState, s)),
          ],
        ),
      ),
    );
  }

  Widget _buildScorePillar(BuildContext context, String title, String val, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: AppColors.outline)),
                Icon(icon, color: color, size: 18),
              ],
            ),
            Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionTile(BuildContext context, AppState appState, s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: s.isApplied ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
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
                  s.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: s.isApplied ? TextDecoration.lineThrough : null,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: s.impactLevel == 'High' ? AppColors.errorContainer : AppColors.warningContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${s.impactLevel} Impact',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: s.impactLevel == 'High' ? AppColors.error : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(s.description, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 10),
          if (!s.isApplied)
            ElevatedButton.icon(
              onPressed: () => appState.applyResumeSuggestion(s.id),
              icon: const Icon(Icons.check_rounded, size: 14),
              label: const Text('Apply Suggestion (+3 ATS)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                textStyle: const TextStyle(fontSize: 11),
              ),
            )
          else
            const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: AppColors.success, size: 14),
                SizedBox(width: 4),
                Text('Applied to Resume', style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
        ],
      ),
    );
  }
}
