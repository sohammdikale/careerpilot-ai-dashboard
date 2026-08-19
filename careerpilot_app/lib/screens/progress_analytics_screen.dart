import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';

class ProgressAnalyticsScreen extends StatelessWidget {
  const ProgressAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final metrics = appState.progressMetrics;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Summary Cards
          if (isMobile) ...[
            _buildStreakCard(context, 'Study Streak', '14 Days 🔥', 'Active Daily Goal', Icons.local_fire_department_rounded, AppColors.error),
            const SizedBox(height: 12),
            _buildStreakCard(context, 'Skill Growth', '+18% 📈', 'This Month', Icons.trending_up_rounded, AppColors.success),
            const SizedBox(height: 12),
            _buildStreakCard(context, 'Weekly Hours', '24.5 Hrs ⏱️', '4.2 hrs/day avg', Icons.access_time_rounded, AppColors.primary),
          ] else ...[
            Row(
              children: [
                Expanded(child: _buildStreakCard(context, 'Study Streak', '14 Days 🔥', 'Active Daily Goal', Icons.local_fire_department_rounded, AppColors.error)),
                const SizedBox(width: 16),
                Expanded(child: _buildStreakCard(context, 'Skill Growth', '+18% 📈', 'This Month', Icons.trending_up_rounded, AppColors.success)),
                const SizedBox(width: 16),
                Expanded(child: _buildStreakCard(context, 'Weekly Hours', '24.5 Hrs ⏱️', '4.2 hrs/day avg', Icons.access_time_rounded, AppColors.primary)),
              ],
            ),
          ],
          const SizedBox(height: 24),

          // Growth Chart Card
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Skill & Readiness Trajectory',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '7-day real-time progress trajectory across skills & interview scores.',
                              style: TextStyle(fontSize: 12, color: AppColors.outline),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLegendDot('Skill', AppColors.primary),
                          const SizedBox(width: 8),
                          _buildLegendDot('Interview', AppColors.success),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // fl_chart LineChart
                  SizedBox(
                    height: 260,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true, drawVerticalLine: false),
                        titlesData: FlTitlesData(
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (val, meta) {
                                final idx = val.toInt();
                                if (idx >= 0 && idx < metrics.length) {
                                  return Text(metrics[idx].day, style: const TextStyle(fontSize: 11, color: AppColors.outline));
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          // Skill Score Line
                          LineChartBarData(
                            spots: metrics.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.skillScore)).toList(),
                            isCurved: true,
                            color: AppColors.primary,
                            barWidth: 4,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.primary.withValues(alpha: 0.1),
                            ),
                          ),
                          // Interview Score Line
                          LineChartBarData(
                            spots: metrics.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.interviewScore)).toList(),
                            isCurved: true,
                            color: AppColors.success,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, String title, String val, String sub, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 12),
            Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color), overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
            Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.outline), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
