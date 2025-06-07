import 'package:flutter/material.dart';
import 'package:task_tracker/utils/app_style.dart';

class TaskListEmptyWidget extends StatelessWidget {
  const TaskListEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No tasks yet.",
        style: AppTextStyles.emptyTitle,
      ),
    );
  }
}
