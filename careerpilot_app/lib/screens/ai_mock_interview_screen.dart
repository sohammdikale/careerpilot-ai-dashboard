import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class AiMockInterviewScreen extends StatefulWidget {
  const AiMockInterviewScreen({super.key});

  @override
  State<AiMockInterviewScreen> createState() => _AiMockInterviewScreenState();
}

class _AiMockInterviewScreenState extends State<AiMockInterviewScreen> {
  bool isRecording = false;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final session = appState.mockInterviews.first;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Mock Technical Interview',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Simulate real machine learning interview questions with instant voice feedback.',
                      style: TextStyle(fontSize: 13, color: AppColors.outline),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: const Text('Next Question'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Question Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(session.category, style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(session.difficulty, style: const TextStyle(color: AppColors.error, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    session.question,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Voice Recorder UI
          Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Text(
                    isRecording ? 'Listening... Speak your answer now' : 'Tap the microphone to record your answer',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isRecording ? AppColors.error : AppColors.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Mic Animated Button
                  GestureDetector(
                    onTap: () async {
                      if (isRecording) {
                        setState(() {
                          isRecording = false;
                          isSubmitted = true;
                        });
                        await appState.evaluateMockInterview(
                          sessionId: session.id,
                          transcript: session.userTranscript ?? 'Self-attention maps input tokens into Query, Key, and Value vectors via linear projection matrices. We compute the dot product of Query and Key to obtain attention weights...',
                        );
                      } else {
                        setState(() {
                          isRecording = true;
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: isRecording ? AppColors.error : AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isRecording ? AppColors.error : AppColors.primary).withValues(alpha: 0.4),
                            blurRadius: isRecording ? 25 : 12,
                            spreadRadius: isRecording ? 6 : 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Simulated Waveform Bars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(isMobile ? 12 : 24, (index) {
                      final height = isRecording ? (12.0 + (index % 5) * 8.0) : 8.0;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        width: 4,
                        height: height,
                        decoration: BoxDecoration(
                          color: isRecording ? AppColors.primary : AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // AI Feedback Breakdown (Shown after recording)
          if (isSubmitted && session.overallScore != null) ...[
            Card(
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
                            'AI Real-Time Evaluation',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.successContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Overall Score: ${session.overallScore}%',
                            style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Metrics breakdown
                    if (isMobile) ...[
                      _buildFeedbackMetric('Technical Depth', '${session.technicalDepthScore}%', AppColors.primary),
                      const SizedBox(height: 10),
                      _buildFeedbackMetric('Clarity', '${session.clarityScore}%', AppColors.secondary),
                      const SizedBox(height: 10),
                      _buildFeedbackMetric('Confidence', '${session.confidenceScore}%', AppColors.success),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(child: _buildFeedbackMetric('Technical Depth', '${session.technicalDepthScore}%', AppColors.primary)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFeedbackMetric('Clarity', '${session.clarityScore}%', AppColors.secondary)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFeedbackMetric('Confidence', '${session.confidenceScore}%', AppColors.success)),
                        ],
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Feedback box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('AI Coach Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 4),
                                Text(
                                  session.aiFeedback!,
                                  style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeedbackMetric(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.outline), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
