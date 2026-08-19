import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool emailNotifications = true;
  bool aiReminders = true;
  bool weeklyReport = true;
  String aiModelPreference = 'Gemini 1.5 Pro / High Precision';
  late TextEditingController _urlController;
  bool _isTesting = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _urlController = TextEditingController(text: appState.serverUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _testConnection(AppState appState) async {
    setState(() => _isTesting = true);
    final success = await appState.testAndSyncBackend(_urlController.text);
    if (mounted) {
      setState(() => _isTesting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? '✅ Successfully connected to backend at ${_urlController.text}'
                : '⚠️ Could not reach backend at ${_urlController.text}. App is using offline mode.',
          ),
          backgroundColor: success ? Colors.green.shade800 : Colors.amber.shade900,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Settings & Preferences',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Configure application preferences, backend REST server URL, and notifications.',
            style: TextStyle(fontSize: 13, color: AppColors.outline),
          ),
          const SizedBox(height: 24),

          // Backend API Server Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        appState.isBackendConnected ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                        color: appState.isBackendConnected ? const Color(0xFF10B981) : Colors.amber.shade800,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Backend API Server',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              appState.isBackendConnected
                                  ? 'Connected & Syncing with FastAPI backend'
                                  : 'Disconnected (Running in Offline Mode)',
                              style: TextStyle(
                                fontSize: 13,
                                color: appState.isBackendConnected ? const Color(0xFF10B981) : Colors.amber.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      labelText: 'FastAPI Backend Base URL',
                      hintText: 'http://10.0.2.2:8000 or http://localhost:8000',
                      prefixIcon: const Icon(Icons.link_rounded),
                      border: const OutlineInputBorder(),
                      suffixIcon: _isTesting
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Preset Buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.phone_android_rounded, size: 16),
                        label: const Text('Android Emulator (10.0.2.2:8000)'),
                        onPressed: () {
                          _urlController.text = 'http://10.0.2.2:8000';
                          _testConnection(appState);
                        },
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.computer_rounded, size: 16),
                        label: const Text('Localhost (localhost:8000)'),
                        onPressed: () {
                          _urlController.text = 'http://localhost:8000';
                          _testConnection(appState);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isTesting ? null : () => _testConnection(appState),
                      icon: const Icon(Icons.sync_rounded),
                      label: const Text('Test Connection & Sync Data'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Appearance Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Appearance & Theme', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Toggle high-contrast dark theme for low-light environments'),
                    secondary: Icon(appState.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: AppColors.primary),
                    value: appState.isDarkMode,
                    onChanged: (_) => appState.toggleTheme(),
                    activeThumbColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // AI Personalization
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AI Engine & Personalization', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.memory_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('AI Analysis Model', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text(aiModelPreference, style: const TextStyle(fontSize: 12, color: AppColors.outline)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: aiModelPreference,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            if (val != null) setState(() => aiModelPreference = val);
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Gemini 1.5 Pro / High Precision',
                              child: Text('Gemini 1.5 Pro / High Precision', overflow: TextOverflow.ellipsis),
                            ),
                            DropdownMenuItem(
                              value: 'Fast Inference Mode',
                              child: Text('Fast Inference Mode', overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Notifications Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notification Preferences', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Email Career Digests'),
                    subtitle: const Text('Receive weekly progress digests and ATS resume updates'),
                    value: emailNotifications,
                    onChanged: (val) => setState(() => emailNotifications = val),
                    activeThumbColor: AppColors.primary,
                  ),
                  SwitchListTile(
                    title: const Text('AI Milestone Reminders'),
                    subtitle: const Text('Nudges to complete pending roadmap items and mock interviews'),
                    value: aiReminders,
                    onChanged: (val) => setState(() => aiReminders = val),
                    activeThumbColor: AppColors.primary,
                  ),
                  SwitchListTile(
                    title: const Text('Weekly Analytics Performance'),
                    subtitle: const Text('Breakdown of weekly study streak and skill improvements'),
                    value: weeklyReport,
                    onChanged: (val) => setState(() => weeklyReport = val),
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
}
