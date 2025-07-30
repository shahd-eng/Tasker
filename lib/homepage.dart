import 'package:flutter/material.dart';
import 'package:tasker/add_task.dart';
import 'package:tasker/date_utils.dart';
import 'package:tasker/db_helper.dart'; // Import the new modal widget

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SqlDb sqlDb = SqlDb();
  List tasks = [];
  bool isLoading = true;

  String? dayNum; //  21
  String? monthName; //  AUG
  String? dayName; //  Wednesday
  String? year; //2019
  Map<int, bool> checkedMap = {};

  // Function to show the added task
  void _showAddTask() async {
    final dynamic taskAdded = await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allows the modal to be larger
      builder: (BuildContext context) {
        return AddTask(); // Using the separated widget
      },
    );
    if(taskAdded !=null){
      setState(() {

      });
    }
  }


  Future<List<Map>> fetchTasks() async {
    List<Map> responses = await sqlDb.read("tasks");
    return responses;
  }


  // Future readData() async {
  //   List<Map> responses = await sqlDb.read("tasks");
  //   tasks.clear();
  //   tasks.addAll(responses);
  //   checkedMap.clear();
  //   for (var task in responses) {
  //     checkedMap[task['id']] = false;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dayNum = now.day.toString();
    monthName = monthAbbreviation(now.month);
    dayName = getDayName(now.weekday);
    year = now.year.toString();
   // readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTask,
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, size: 40, color: Colors.white),
        ),
        title: Text(
          'Tasker',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 100,
              color: Colors.blue,
              child: Row(
                children: [
                  Text(
                    dayNum ?? "21",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        monthName ?? "AUG",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        year ?? "2019",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    dayName ?? "Wednesday",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            FutureBuilder(future: fetchTasks(),
                builder: (context,snapshot){
              if(!snapshot.hasData)
                {
                  return Center(child: CircularProgressIndicator());
                }
              final tasks=snapshot.data!;
              if(tasks.isEmpty)
                {
                  return Center(child: Text("No tasks found"),);
                }
              return ListView.builder(
                itemCount:tasks.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          final taskId = tasks[i]['id'];
                          setState(() {
                            checkedMap[taskId] = !(checkedMap[taskId] ?? false);
                          });
                        },
                        icon: Icon(
                          (checkedMap[tasks[i]['id']] ?? false)
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color:
                          (checkedMap[tasks[i]['id']] ?? false)
                              ? Colors.blue
                              : Colors.grey,
                          size: 24,
                        ),
                      ),
                      title: Text("${tasks[i]['task']}"),
                      subtitle: Text(formatDateToDays(tasks[i]['date'])),
                      trailing: IconButton(
                        onPressed: () async {
                          int response = await sqlDb.delete(
                            "tasks",
                            "id=${tasks[i]['id']}",
                          );
                          if (response > 0) {
                            tasks.removeWhere(
                                  (element) => element['id'] == tasks[i]['id'],
                            );
                            setState(() {});
                          }
                        },
                        icon: Icon(Icons.delete, color: Colors.blue),
                      ),
                    ),
                  );
                },
              );


                }

            ),


          ],
        ),
      ),
    );
  }
}
