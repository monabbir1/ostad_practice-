import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todoscreen extends StatefulWidget {
  const Todoscreen({super.key});

  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  List<Map<String, dynamic>> tasks = [];
  bool showActiveTask = true;

  void _showTaskDialog({int? index}) {
    TextEditingController _taskController = TextEditingController(
      text: index != null ? tasks[index]['task'] : '',
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(index != null ? 'Edit Task' : 'Add Task'),
              content: TextFormField(
                controller: _taskController,
                decoration: InputDecoration(hintText: 'Enter Task'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      if (_taskController.text.trim().isNotEmpty) {
                        if(index == null){
                          _addTask(_taskController.text);
                        }else{
                          _editeTask(index, _taskController.text);
                        }
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }

  void _addTask(String task) {
    setState(() {
      tasks.add({"task": task, "completed": false});
    });
    Navigator.pop(context);
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _editeTask (int index,String updateTask){
    setState(() {
      tasks[index]['task'] = updateTask;
    });
    Navigator.pop(context);
  }

  int get activeCount => tasks.where((task) => !task['completed']).length;
  int get completeCount => tasks.where((task) => task['completed']).length;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 4),
                          blurRadius: 5)
                    ]),
                padding: EdgeInsets.all(20),
                child: Text(
                  "Active \n ${activeCount.toString()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 4),
                          blurRadius: 5)
                    ]),
                padding: EdgeInsets.all(20),
                child: Text(
                  "Completed \n ${completeCount.toString()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(UniqueKey().toString()),
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(Icons.check,color: Colors.white,),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete,color: Colors.white,),
                      ),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        if(direction == DismissDirection.startToEnd){
                          _toggleTaskStatus(index);
                        }else{
                          _deleteTask(index);
                        }
                      });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(tasks[index]['task'],style: TextStyle(
                          fontSize: 16,
                          decoration: tasks[index]['completed'] ? TextDecoration.lineThrough : null,
                        ),),
                        leading: Checkbox(value:tasks[index]['completed'] , onChanged: (value)=> _toggleTaskStatus(index)),
                        trailing: IconButton(onPressed: ()=> _showTaskDialog(index: index), icon: Icon(Icons.edit)),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}
