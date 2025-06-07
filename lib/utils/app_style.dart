import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF8F9FC);
  static const card = Color(0xFFFFFFFF);
  static const primary = Color(0xFF6A5AE0);
  static const accent = Color.fromARGB(255, 91, 236, 125);
  static const warning = Color(0xFFFFD6A5);
  static const danger = Color(0xFFFF9AA2);
  static const info = Color(0xFFAECFFF);
  static const gray = Color(0xFF9AA0B3);

  static const progressLabel = Color(0xFF9C9DA5); // สีสำหรับ label
  static const progressStatus = Color(0xFFB0B4C1); // สีข้อความรอง
  static const white = Colors.white;
  static const shadow = Color(0x11000000);
}

class AppTextStyles {
  static const bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.gray,
  );

  static const progressNotDoneText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.danger,
  );

  static const progressDoneText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.accent,
  );

  static const progressLabel = TextStyle(
    fontSize: 14,
    color: AppColors.progressLabel,
  );

  static const progressStatus = TextStyle(
    fontSize: 12,
    color: AppColors.progressStatus,
  );

  static const title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.primary,
  );

  static const subtitle = TextStyle(fontSize: 14, color: AppColors.white);

  static const taskTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const taskTitleDone = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.gray,
    decoration: TextDecoration.lineThrough,
  );

  static const time = TextStyle(
    fontSize: 13,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  static const badgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const emptyTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.gray,
  );

  static const emptySubtitle = TextStyle(fontSize: 14, color: AppColors.gray);
}

class AppDecorations {
  static BoxDecoration taskCard(bool isDone) => BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, 4)),
    ],
    border: Border.all(
      color: isDone ? AppColors.accent : Colors.transparent,
      width: 1.2,
    ),
  );
}

class AppPaddings {
  static const page = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  static const card = EdgeInsets.symmetric(vertical: 14, horizontal: 18);
  static const list = EdgeInsets.all(16);
}

class AppIcons {
  static const done = Icon(Icons.check, color: AppColors.white);
  static const notDone = Icon(Icons.radio_button_unchecked, color: Colors.grey);
}
