// ignore_for_file: prefer_const_constructors

import 'main_export.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emovied',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
