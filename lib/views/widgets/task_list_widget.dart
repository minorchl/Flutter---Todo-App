import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_tracker/models/task_model.dart';
import 'package:task_tracker/utils/app_style.dart';
import 'package:task_tracker/viewmodels/task_view_model.dart';
import 'package:task_tracker/widgets/confirm_dialog.dart';
import 'package:task_tracker/widgets/edit_task_dialog.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;
  final TaskViewModel viewModel;
  const TaskListWidget({
    super.key,
    required this.viewModel,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = viewModel.groupedTasksByDate;

    return SlidableAutoCloseBehavior(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children:
            grouped.entries.expand((entry) {
              final date = entry.key;
              final tasks = entry.value;

              return [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    date,
                    style: AppTextStyles.taskTitle.copyWith(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                ...tasks.map(
                  (task) => TaskItemWidget(task: task, viewModel: viewModel),
                ),
              ];
            }).toList(),
      ),
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.task,
    required this.viewModel,
  });

  final Task task;
  final TaskViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Slidable(
            key: ObjectKey(task),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.50,
              children: [
                SlidableAction(
                  onPressed:
                      (_) => showEditTaskDialog(
                        context: context,
                        initialTitle: task.title,
                        initialDeadline: task.deadline,
                        initialIsDone: task.isDone,
                        onSave: (title, deadline, isDone) async {
                          final updatedTask = Task(
                            title: title,
                            deadline: deadline,
                            isDone: isDone,
                          );
                          await viewModel.editTask(
                            task.key as int,
                            updatedTask,
                          );
                        },
                      ),
                  backgroundColor: AppColors.warning,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed:
                      (_) => showConfirmDeleteDialog(
                        context: context,
                        onConfirm: () async {
                          await viewModel.deleteTask(task.key as int);
                        },
                      ),
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              onTap: () => viewModel.toggleDone(task),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: task.isDone ? AppColors.accent : Colors.amber,
                child: Icon(
                  task.isDone ? Icons.check : Icons.pending,
                  color: Colors.white,
                ),
              ),
              title: Text(
                task.title,
                style:
                    task.isDone
                        ? AppTextStyles.taskTitleDone
                        : AppTextStyles.taskTitle.copyWith(fontSize: 15),
              ),
              subtitle: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Due: ${task.deadline.toLocal().toString().split(' ')[0]}",
                    style: AppTextStyles.progressStatus,
                  ),
                ],
              ),
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    task.isDone
                        ? Text("Done", style: AppTextStyles.progressDoneText)
                        : Text(
                          "Inprogress",
                          style: AppTextStyles.progressNotDoneText,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
