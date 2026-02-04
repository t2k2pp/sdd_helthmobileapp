import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../health_data/presentation/providers/health_data_provider.dart';

/// ダッシュボード画面 - 今日の健康データサマリー
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStepsAsync = ref.watch(todayStepsProvider);
    final weightRecordsAsync = ref.watch(weightRecordsProvider);
    final temperatureRecordsAsync = ref.watch(temperatureRecordsProvider);
    final exerciseRecordsAsync = ref.watch(exerciseRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('健康管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(todayStepsProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(todayStepsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 日付表示
              Text(
                DateFormat('yyyy年MM月dd日（E）', 'ja').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              // 歩数カード
              _HealthCard(
                title: '歩数',
                icon: Icons.directions_walk,
                color: AppTheme.stepsColor,
                child: todayStepsAsync.when(
                  data: (steps) => _MetricDisplay(
                    value: steps.toString(),
                    unit: '歩',
                    goal: 8000,
                    current: steps,
                  ),
                  loading: () => const _LoadingIndicator(),
                  error: (e, _) => _ErrorDisplay(message: '歩数を取得できません'),
                ),
              ),
              const SizedBox(height: 12),

              // 体重カード
              _HealthCard(
                title: '体重',
                icon: Icons.monitor_weight,
                color: AppTheme.weightColor,
                child: weightRecordsAsync.when(
                  data: (records) {
                    if (records.isEmpty) {
                      return const _EmptyDisplay(message: '記録なし');
                    }
                    final latest = records.first;
                    return _MetricDisplay(
                      value: latest.weight.toStringAsFixed(1),
                      unit: 'kg',
                    );
                  },
                  loading: () => const _LoadingIndicator(),
                  error: (e, _) => _ErrorDisplay(message: 'データを取得できません'),
                ),
              ),
              const SizedBox(height: 12),

              // 体温カード
              _HealthCard(
                title: '体温',
                icon: Icons.thermostat,
                color: AppTheme.temperatureColor,
                child: temperatureRecordsAsync.when(
                  data: (records) {
                    if (records.isEmpty) {
                      return const _EmptyDisplay(message: '記録なし');
                    }
                    final latest = records.first;
                    return _MetricDisplay(
                      value: latest.temperature.toStringAsFixed(1),
                      unit: '℃',
                    );
                  },
                  loading: () => const _LoadingIndicator(),
                  error: (e, _) => _ErrorDisplay(message: 'データを取得できません'),
                ),
              ),
              const SizedBox(height: 12),

              // 運動カード
              _HealthCard(
                title: '運動',
                icon: Icons.fitness_center,
                color: AppTheme.exerciseColor,
                child: exerciseRecordsAsync.when(
                  data: (records) {
                    // 今日の運動時間を合計
                    final today = DateTime.now();
                    final todayStart = DateTime(today.year, today.month, today.day);
                    final todayRecords = records.where(
                      (r) => r.date.isAfter(todayStart),
                    );
                    final totalMinutes = todayRecords.fold<int>(
                      0,
                      (sum, r) => sum + r.durationMinutes,
                    );
                    return _MetricDisplay(
                      value: totalMinutes.toString(),
                      unit: '分',
                      goal: 30,
                      current: totalMinutes,
                    );
                  },
                  loading: () => const _LoadingIndicator(),
                  error: (e, _) => _ErrorDisplay(message: 'データを取得できません'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 健康データカード
class _HealthCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  const _HealthCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 4),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// メトリクス表示
class _MetricDisplay extends StatelessWidget {
  final String value;
  final String unit;
  final int? goal;
  final int? current;

  const _MetricDisplay({
    required this.value,
    required this.unit,
    this.goal,
    this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        if (goal != null && current != null) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (current! / goal!).clamp(0.0, 1.0),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 4),
          Text(
            '目標: $goal$unit',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

/// ローディング表示
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 32,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

/// エラー表示
class _ErrorDisplay extends StatelessWidget {
  final String message;

  const _ErrorDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}

/// 空データ表示
class _EmptyDisplay extends StatelessWidget {
  final String message;

  const _EmptyDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey,
          ),
    );
  }
}
