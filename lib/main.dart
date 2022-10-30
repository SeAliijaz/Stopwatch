import 'package:flutter/material.dart';
import 'package:stopwatch/Screens/stop_watch_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      home: StopWatchScreen(),
    );
  }
}
