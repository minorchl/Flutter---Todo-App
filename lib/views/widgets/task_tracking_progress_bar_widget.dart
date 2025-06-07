import 'package:flutter/material.dart';
import 'package:task_tracker/utils/app_style.dart';

class TaskTrackingProgressBarWidget extends StatelessWidget {
  const TaskTrackingProgressBarWidget({
    super.key,
    required this.percent,
    required this.completed,
    required this.total,
  });

  final double percent;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Progress", style: AppTextStyles.progressLabel),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[300],
              color: AppColors.accent,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$completed of $total tasks completed",
            style: AppTextStyles.progressStatus,
          ),
        ],
      ),
    );
  }
}
