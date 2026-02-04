import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

/// 目標設定画面 - 歩数、体重、運動時間の目標を設定
class GoalScreen extends ConsumerStatefulWidget {
  const GoalScreen({super.key});

  @override
  ConsumerState<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends ConsumerState<GoalScreen> {
  late int _stepsGoal;
  late double _weightGoal;
  late int _exerciseGoal;

  @override
  void initState() {
    super.initState();
    _stepsGoal = AppConstants.defaultStepGoal;
    _weightGoal = AppConstants.defaultWeightGoal;
    _exerciseGoal = AppConstants.defaultExerciseGoal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('目標設定'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 歩数目標
            _GoalCard(
              title: '歩数目標',
              icon: Icons.directions_walk,
              color: AppTheme.stepsColor,
              currentValue: '$_stepsGoal 歩',
              child: Column(
                children: [
                  Slider(
                    value: _stepsGoal.toDouble(),
                    min: 1000,
                    max: 30000,
                    divisions: 29,
                    label: '$_stepsGoal 歩',
                    onChanged: (value) {
                      setState(() => _stepsGoal = value.round());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('1,000歩'),
                      Text('$_stepsGoal 歩',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text('30,000歩'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 体重目標
            _GoalCard(
              title: '体重目標',
              icon: Icons.monitor_weight,
              color: AppTheme.weightColor,
              currentValue: '${_weightGoal.toStringAsFixed(1)} kg',
              child: Column(
                children: [
                  Slider(
                    value: _weightGoal,
                    min: 30,
                    max: 150,
                    divisions: 240,
                    label: '${_weightGoal.toStringAsFixed(1)} kg',
                    onChanged: (value) {
                      setState(() => _weightGoal = value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('30 kg'),
                      Text('${_weightGoal.toStringAsFixed(1)} kg',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text('150 kg'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 運動目標
            _GoalCard(
              title: '運動時間目標',
              icon: Icons.fitness_center,
              color: AppTheme.exerciseColor,
              currentValue: '$_exerciseGoal 分/日',
              child: Column(
                children: [
                  Slider(
                    value: _exerciseGoal.toDouble(),
                    min: 10,
                    max: 120,
                    divisions: 22,
                    label: '$_exerciseGoal 分',
                    onChanged: (value) {
                      setState(() => _exerciseGoal = value.round());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('10分'),
                      Text('$_exerciseGoal 分',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text('120分'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed: _saveGoals,
              icon: const Icon(Icons.save),
              label: const Text('目標を保存'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveGoals() {
    // TODO: SharedPreferencesまたはDBに保存
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('目標を保存しました'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

/// 目標カード
class _GoalCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String currentValue;
  final Widget child;

  const _GoalCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.currentValue,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    currentValue,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
