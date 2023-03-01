import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archive_tasks/archive_screen.dart';
import 'package:todo_app/modules/done_tasks/done_task_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';

class homeLayout extends StatefulWidget {

  @override
  State<homeLayout> createState() => _homeLayoutState();
}

class _homeLayoutState extends State<homeLayout> {

  List<Widget> screens=[
    newTaskScreen(),
    doneTaskScreen(),
    archiveTaskScreen(),
  ];
  List<String> titles=
  [
    "New Tasks",
    "Done Tasks",
    "Archive Tasks",
  ];
  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screens[currentIndex] ,
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
            // print("welcome");
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index)
        {
          setState(() {
            currentIndex =index;
          });
        },
        items: const [
           BottomNavigationBarItem(
             icon:  Icon(
               Icons.menu,
             ),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon:   Icon(
              Icons.check_circle,
            ),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon:  Icon(
              Icons.archive,
            ),
            label: "Archive",
          ),
        ],
      ),
    );
  }

  void createDatabase () async
  {
    var database= await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
        {
          // print("database created");
          database.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
          ).then((value){
            // print("table created");
          }).catchError((error){
            // print(error.toString());
          });
        },
      onOpen: (database)
        {
          // print("database opened");
        },
    );
  }
}
