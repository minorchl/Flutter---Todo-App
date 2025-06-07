import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/models/task_model.dart';
import 'package:task_tracker/services/task_local_service.dart';
import 'package:task_tracker/utils/hive_boxs.dart';
import 'package:task_tracker/viewmodels/task_view_model.dart';
import 'package:task_tracker/views/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>(HiveBoxes.tasks);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel(TaskLocalService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.maliTextTheme()),
        home: TaskScreen(),
      ),
    );
  }
}
