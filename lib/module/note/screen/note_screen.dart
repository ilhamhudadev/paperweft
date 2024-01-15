import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperweft/core/style/app_color.dart';
import 'package:paperweft/core/style/app_size.dart';
import 'package:paperweft/core/style/app_typography.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

enum TaskStatus { notDone, done }

class NoteMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paperweft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteScreen(),
    );
  }
}

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Database _database;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _deadlineDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  late List<Task> _tasks;
  late List<Task> _filteredTasks;

  @override
  void initState() {
    super.initState();
    _tasks = [];
    _filteredTasks = [];
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, task TEXT, creationDate TEXT, deadlineDate TEXT, status TEXT)',
        );
      },
      version: 1,
    );
    _updateTaskList();
  }

  Future<void> _insertTask(Task task) async {
    await _database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _updateTaskList();
  }

  Future<void> _updateTask(Task task) async {
    await _database.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    _updateTaskList();
  }

  Future<void> _deleteTask(int id) async {
    await _database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    _updateTaskList();
  }

  Future<void> _updateTaskList() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');
    setState(() {
      _tasks.clear();
      _tasks.addAll(List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      }));
      _filteredTasks = List.from(_tasks);
    });
  }

  Future<void> _showAddTaskDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                ),
              ),
              TextField(
                controller: _creationDateController,
                decoration: InputDecoration(
                  labelText: 'Creation Date (YYYY-MM-DD)',
                ),
              ),
              TextField(
                controller: _deadlineDateController,
                decoration: InputDecoration(
                  labelText: 'Deadline Date (YYYY-MM-DD)',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _taskController.text.isNotEmpty &&
                    _creationDateController.text.isNotEmpty &&
                    _deadlineDateController.text.isNotEmpty) {
                  _insertTask(Task(
                    title: _titleController.text,
                    task: _taskController.text,
                    creationDate: _creationDateController.text,
                    deadlineDate: _deadlineDateController.text,
                    status: TaskStatus.notDone, // Default status is notDone
                  ));
                  _titleController.clear();
                  _taskController.clear();
                  _creationDateController.clear();
                  _deadlineDateController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(Task task, context) async {
    _titleController.text = task.title;
    _taskController.text = task.task;
    _creationDateController.text = task.creationDate;
    _deadlineDateController.text = task.deadlineDate;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                ),
              ),
              TextField(
                controller: _creationDateController,
                decoration: InputDecoration(
                  labelText: 'Creation Date',
                ),
              ),
              TextField(
                controller: _deadlineDateController,
                decoration: InputDecoration(
                  labelText: 'Deadline Date',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _taskController.text.isNotEmpty &&
                    _creationDateController.text.isNotEmpty &&
                    _deadlineDateController.text.isNotEmpty) {
                  _updateTask(Task(
                    id: task.id,
                    title: _titleController.text,
                    task: _taskController.text,
                    creationDate: _creationDateController.text,
                    deadlineDate: _deadlineDateController.text,
                    status: task.status,
                  ));
                  _titleController.clear();
                  _taskController.clear();
                  _creationDateController.clear();
                  _deadlineDateController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _performSearch(String query) {
    setState(() {
      _filteredTasks = _tasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showSearchDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search Tasks'),
          content: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Enter search query',
                ),
                onChanged: (query) {
                  _performSearch(query);
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTaskStatus(Task task) async {
    Task updatedTask = Task(
      id: task.id,
      title: task.title,
      task: task.task,
      creationDate: task.creationDate,
      deadlineDate: task.deadlineDate,
      status: task.status == TaskStatus.notDone
          ? TaskStatus.done
          : TaskStatus.notDone,
    );
    await _updateTask(updatedTask);
  }

  Widget search() {
    TextEditingController searchController = TextEditingController();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      color: AppColors.greywhite,
      child: Row(children: [
        // SvgPicture.asset(AppAssets.search),
        const SizedBox(
          width: 19,
        ),
        Expanded(
            flex: 1,
            child: TextField(
              onChanged: _performSearch,
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _searchController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: "Search Task",
              ),
            ))
      ]),
    );
  }

  Widget section(article, context) {
    bool isdark = true;
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // SvgPicture.asset(image),
                Icon(
                  Icons.radio_button_checked,
                  color: isdark == true ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: AppSize.screenWidth * 0.7,
                    child: Text(
                      article.creationDate,
                      style: AppTypography.body2(
                        color: isdark == true ? Colors.black : Colors.white,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: isdark == true ? Colors.black : Colors.white,
                          width: 4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(article.content.toString(),
                  //     style: AppTypography.body2()),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(EditArticleScreen(
                        //   article: article,
                        // ));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            width: AppSize.screenWidth * 0.8,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isdark == true
                                  ? Colors.black87
                                  : Colors.white,
                              border: Border.all(
                                  color: isdark == true
                                      ? Colors.white
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.deadlineDate.toString(),
                                    style: AppTypography.body2(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                                Text(article.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.headline6(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                                Row(
                                  children: [],
                                ),
                                Text(article.task.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTypography.body2(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            article.status == TaskStatus.notDone
                                                ? Icons.check_box_outline_blank
                                                : Icons.check_box,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _toggleTaskStatus(article);
                                          },
                                        ),
                                        Text(
                                            "${article.status == TaskStatus.notDone ? 'Not Done' : 'Done'}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.body2(
                                                color: isdark == true
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ],
                                    ),
                                    Row(children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _showEditTaskDialog(article, context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _deleteTask(article.id ?? 0);
                                        },
                                      ),
                                    ])
                                  ],
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'To Do List',
          style: AppTypography.headline6(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showAddTaskDialog(context);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          search(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       filled: true,
          //       fillColor: Colors.white,
          //     ),
          //     onChanged: _performSearch,
          //   ),
          // ),
          Expanded(
              child: ListView.builder(
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = _filteredTasks[index];
                    debugPrint(
                        "_filteredTasks.length, ${_filteredTasks.length}");
                    return section(task, context);
                  })),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _filteredTasks.length,
          //     itemBuilder: (context, index) {
          //       final task = _filteredTasks[index];
          //       return ListTile(
          //         title: Text(
          //           '${task.title}: ${task.task}\n'
          //           'Created: ${task.creationDate}\n'
          //           'Deadline: ${task.deadlineDate}\n'
          //           'Status: ${task.status == TaskStatus.notDone ? 'Not Done' : 'Done'}',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         trailing: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             IconButton(
          //               icon: Icon(
          //                 Icons.edit,
          //                 color: Colors.white,
          //               ),
          //               onPressed: () {
          //                 _showEditTaskDialog(task, context);
          //               },
          //             ),
          //             IconButton(
          //               icon: Icon(
          //                 Icons.delete,
          //                 color: Colors.white,
          //               ),
          //               onPressed: () {
          //                 _deleteTask(task.id ?? 0);
          //               },
          //             ),
          //             IconButton(
          //               icon: Icon(
          //                 task.status == TaskStatus.notDone
          //                     ? Icons.check_box_outline_blank
          //                     : Icons.check_box,
          //                 color: Colors.white,
          //               ),
          //               onPressed: () {
          //                 _toggleTaskStatus(task);
          //               },
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Task {
  int? id;
  final String title;
  final String task;
  final String creationDate;
  final String deadlineDate;
  final TaskStatus status;

  Task({
    this.id,
    required this.title,
    required this.task,
    required this.creationDate,
    required this.deadlineDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'title': title,
      'task': task,
      'creationDate': creationDate,
      'deadlineDate': deadlineDate,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      task: map['task'],
      creationDate: map['creationDate'],
      deadlineDate: map['deadlineDate'],
      status: map['status'] == 'done' ? TaskStatus.done : TaskStatus.notDone,
    );
  }
}
