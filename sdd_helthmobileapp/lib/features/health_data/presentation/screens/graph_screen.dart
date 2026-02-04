import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/health_data_provider.dart';

/// グラフ表示画面 - 健康データの推移を可視化
class GraphScreen extends ConsumerStatefulWidget {
  const GraphScreen({super.key});

  @override
  ConsumerState<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends ConsumerState<GraphScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedDays = 7; // 表示期間

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('グラフ'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '歩数'),
            Tab(text: '体重'),
            Tab(text: '体温'),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _selectedDays,
            onSelected: (days) {
              setState(() => _selectedDays = days);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 7, child: Text('1週間')),
              const PopupMenuItem(value: 14, child: Text('2週間')),
              const PopupMenuItem(value: 30, child: Text('1ヶ月')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('${_selectedDays}日'),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _StepsChart(days: _selectedDays),
          _WeightChart(days: _selectedDays),
          _TemperatureChart(days: _selectedDays),
        ],
      ),
    );
  }
}

/// 歩数グラフ
class _StepsChart extends ConsumerWidget {
  final int days;

  const _StepsChart({required this.days});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsAsync = ref.watch(stepRecordsProvider);

    return stepsAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return const Center(child: Text('データがありません'));
        }

        final now = DateTime.now();
        final startDate = now.subtract(Duration(days: days));
        final filteredRecords = records
            .where((r) => r.date.isAfter(startDate))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        if (filteredRecords.isEmpty) {
          return const Center(child: Text('期間内のデータがありません'));
        }

        final spots = filteredRecords.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.steps.toDouble());
        }).toList();

        final maxY = filteredRecords
            .map((r) => r.steps)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() * 1.2;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < filteredRecords.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            DateFormat('M/d').format(filteredRecords[index].date),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    interval: (filteredRecords.length / 5).ceilToDouble(),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppTheme.stepsColor,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppTheme.stepsColor.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('エラー: $e')),
    );
  }
}

/// 体重グラフ
class _WeightChart extends ConsumerWidget {
  final int days;

  const _WeightChart({required this.days});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightAsync = ref.watch(weightRecordsProvider);

    return weightAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return const Center(child: Text('データがありません'));
        }

        final now = DateTime.now();
        final startDate = now.subtract(Duration(days: days));
        final filteredRecords = records
            .where((r) => r.date.isAfter(startDate))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        if (filteredRecords.isEmpty) {
          return const Center(child: Text('期間内のデータがありません'));
        }

        final spots = filteredRecords.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.weight);
        }).toList();

        final weights = filteredRecords.map((r) => r.weight).toList();
        final minWeight = weights.reduce((a, b) => a < b ? a : b);
        final maxWeight = weights.reduce((a, b) => a > b ? a : b);
        final padding = (maxWeight - minWeight) * 0.2;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < filteredRecords.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            DateFormat('M/d').format(filteredRecords[index].date),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    interval: (filteredRecords.length / 5).ceilToDouble(),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              minY: minWeight - padding,
              maxY: maxWeight + padding,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppTheme.weightColor,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppTheme.weightColor.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('エラー: $e')),
    );
  }
}

/// 体温グラフ
class _TemperatureChart extends ConsumerWidget {
  final int days;

  const _TemperatureChart({required this.days});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempAsync = ref.watch(temperatureRecordsProvider);

    return tempAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return const Center(child: Text('データがありません'));
        }

        final now = DateTime.now();
        final startDate = now.subtract(Duration(days: days));
        final filteredRecords = records
            .where((r) => r.date.isAfter(startDate))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        if (filteredRecords.isEmpty) {
          return const Center(child: Text('期間内のデータがありません'));
        }

        final spots = filteredRecords.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.temperature);
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < filteredRecords.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            DateFormat('M/d').format(filteredRecords[index].date),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    interval: (filteredRecords.length / 5).ceilToDouble(),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              minY: 35.0,
              maxY: 39.0,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppTheme.temperatureColor,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppTheme.temperatureColor.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('エラー: $e')),
    );
  }
}
