import 'package:flutter/material.dart';
import 'package:tasker/add_task.dart';
import 'package:tasker/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,),
      ),
      home: Homepage(),
      routes: {
        "add_task":(context)=>AddTask(),
      },

    );
  }
}

