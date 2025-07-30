import 'package:flutter/material.dart';

Future<DateTime?> showCalendar(BuildContext context) {
  return showDatePicker(
    context: context,
    firstDate: DateTime(2015),
    lastDate: DateTime(2030),
    initialDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),
        ),
        child: child!,
      );
    },
  );
}




