import 'package:flutter/material.dart';
import 'package:tasker/db_helper.dart';
import 'package:tasker/calendar.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  SqlDb sqlDb = SqlDb();
  DateTime? selectedDate;

  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: TextFormField(
                controller: taskController,
                decoration: InputDecoration(hintText: "Task"),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(labelText: "No due date"),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    DateTime? date = await showCalendar(context);
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        dateController.text =
                            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                      });
                    }
                  },

                  icon: Icon(Icons.calendar_today, color: Colors.blue),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    "Canceled",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    int response = await sqlDb.insert("tasks", {
                      "task": "${taskController.text}",
                      "date": "${dateController.text}",
                    });
                    print("===========response========");
                    print(response);
                    if (response > 1) {
                      Navigator.of(
                        context,
                      ).pop({"success": true, "date": selectedDate});
                    } else {
                      Navigator.of(context).pop(false);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
