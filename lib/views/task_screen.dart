import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/utils/app_style.dart';
import 'package:task_tracker/viewmodels/task_view_model.dart';
import 'package:task_tracker/views/widgets/floating_action_button_widget.dart';
import 'package:task_tracker/views/widgets/task_list_empty_widget.dart';
import 'package:task_tracker/views/widgets/task_list_widget.dart';
import 'package:task_tracker/views/widgets/task_tracking_progress_bar_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final tasks = viewModel.filteredTasks;
    final total = viewModel.tasks.length;
    final completed = viewModel.tasks.where((t) => t.isDone).length;
    final percent = total == 0 ? 0.0 : completed / total;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text("TO-DO Today", style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterRow(viewModel),
          if (tasks.isNotEmpty)
            TaskTrackingProgressBarWidget(percent: percent, completed: completed, total: total),
          Expanded(
            child:
                tasks.isEmpty
                    ? TaskListEmptyWidget()
                    : TaskListWidget(tasks: tasks, viewModel: viewModel),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(viewModel: viewModel),
    );
  }

  Widget _buildFilterRow(TaskViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFilterChip("All", TaskFilter.all, viewModel),
          SizedBox(width: 5),
          _buildFilterChip("In Progress", TaskFilter.inProgress, viewModel),
          SizedBox(width: 5),
          _buildFilterChip("Completed", TaskFilter.completed, viewModel),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    TaskFilter filter,
    TaskViewModel viewModel,
  ) {
    final isSelected = viewModel.filter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => viewModel.setFilter(filter),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}

