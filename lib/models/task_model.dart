import 'package:objectbox/objectbox.dart';

//to avoid those kind of erros
/* 
  1- add the @Id() annotation, when your data id's name is not id
  example
  @Id()
  int task_id;
  2- make sure to build the class after writing the @Entity() annotation

  3- make sure that the class name is the same as the file name
 */

@Entity()
class TaskModel {
  int id = 0;
  String? task_title;
  String? task_description;
  bool? task_done;
  DateTime? creation_date;

  TaskModel(
      {this.task_title,
      this.task_description,
      this.task_done,
      this.creation_date});
}

//now let's generate our model to an objectbox object