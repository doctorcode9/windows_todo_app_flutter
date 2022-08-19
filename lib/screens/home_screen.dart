import 'package:desktop_todo_app_tut/main.dart';
import 'package:desktop_todo_app_tut/models/task_model.dart';
import 'package:desktop_todo_app_tut/objectbox.g.dart';
import 'package:desktop_todo_app_tut/screens/task_editor_screen.dart';
import 'package:desktop_todo_app_tut/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //okey now let's try to add a task
  Box<TaskModel>? taskBox;
  //okey now let's create a stream to stream all the data
  Stream<List<TaskModel>>? fetchAllTask;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskBox = objectBox.store.box<TaskModel>();
    print(taskBox!.count());
    setState(() {
      fetchAllTask = taskBox!
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    objectBox.store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(18.0),
          width: MediaQuery.of(context).size.width *
              0.8, //we want to make the content of the app make 80% of the app size since we're building a desktop app
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "👋 Welcome Sir",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      //when we press this button we want to navigate to the task editor screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskEditorScreen()));
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add a new Task"),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              //Now that we finished the UI of the home page let's create the task editor ui
              //Now let's build a stream builder to display all the task
              StreamBuilder<List<TaskModel>>(
                stream: fetchAllTask!,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                            children: snapshot.data!
                                .map((e) => TaskWidget(e))
                                .toList()),
                      );
                    }
                  }

                  return Center();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
