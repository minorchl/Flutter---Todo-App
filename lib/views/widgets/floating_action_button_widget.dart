import 'package:flutter/material.dart';
import 'package:task_tracker/models/task_model.dart';
import 'package:task_tracker/utils/app_style.dart';
import 'package:task_tracker/viewmodels/task_view_model.dart';
import 'package:task_tracker/widgets/add_task_dialog.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, required this.viewModel});

  final TaskViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () {
        showAddTaskDialog(
          context: context,
          onSave: (title, deadline, isDone) async {
            final newTask = Task(
              title: title,
              deadline: deadline,
              isDone: isDone,
            );
            await viewModel.addTask(newTask);
          },
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
