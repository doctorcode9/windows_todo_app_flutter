import 'package:desktop_todo_app_tut/main.dart';
import 'package:desktop_todo_app_tut/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget(this.task, {Key? key}) : super(key: key);
  TaskModel task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  Box<TaskModel> taskBox = objectBox.store.box<TaskModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Checkbox(
          side: BorderSide(color: Colors.white),
          value: widget.task.task_done,
          onChanged: (value) {
            widget.task.task_done = value;
            taskBox.put(widget.task);
            // note that to update an object in object box we use the same function as to create a new one, Object box detect the id and know if he has to update or create
          },
        ),
        Expanded(
          child: Text(widget.task.task_title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              )),
        ),
        IconButton(
          onPressed: () {
            taskBox.remove(widget.task.id);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        )
      ]),
    );
  }
}
