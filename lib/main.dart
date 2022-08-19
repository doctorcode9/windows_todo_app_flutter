import 'package:desktop_todo_app_tut/helpers/objectbox_interface.dart';
import 'package:desktop_todo_app_tut/screens/home_screen.dart';
import 'package:flutter/material.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}


//first of all let's start creating the folder structure of the app
/* Now let's build the basic UI of the Home Screen */
// now that we finished creating the UI of the App, let's start implementing the database function
// now let's add the objectox dependeies
//Okey ow that we have all the dependecies, let's start creating our first entity to store task
//now let's make our helper class, to allow us to use the database among our app
//let's run our app to check that the code works
//now let's create a custom widget for our task