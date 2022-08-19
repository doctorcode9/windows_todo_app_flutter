import 'package:desktop_todo_app_tut/main.dart';
import 'package:desktop_todo_app_tut/models/task_model.dart';
import 'package:desktop_todo_app_tut/objectbox.g.dart';
import 'package:flutter/material.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({Key? key}) : super(key: key);

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  Box<TaskModel> taskBox = objectBox.store.box<TaskModel>();

  //let's create the editor controller
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0.0,
        title: Text("Create a new Task"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24.0),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _taskTitleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white12),
                    hintText: "Type your Task Title eg: Buy some Milk",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Task Description",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _taskDescriptionController,
                style: TextStyle(color: Colors.white),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white12),
                    hintText: "Type your Task description",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      //here we will add the function to add a new Task
                      String taskTitle = _taskTitleController.text;
                      String taskDescription = _taskDescriptionController.text;
                      TaskModel model = TaskModel(
                          task_title: taskTitle,
                          task_description: taskDescription,
                          task_done: false,
                          creation_date: DateTime.now());
                      taskBox.put(model);
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    child: Text("Save Task"),
                    elevation: 0.0,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
