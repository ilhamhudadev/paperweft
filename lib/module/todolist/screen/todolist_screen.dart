import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

enum TaskStatus { notDone, done }

class ToDoListMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('To Do List'),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _performSearch,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
                return ListTile(
                  title: Text(
                    '${task.title}: ${task.task}\n'
                    'Created: ${task.creationDate}\n'
                    'Deadline: ${task.deadlineDate}\n'
                    'Status: ${task.status == TaskStatus.notDone ? 'Not Done' : 'Done'}',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _showEditTaskDialog(task, context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _deleteTask(task.id ?? 0);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          task.status == TaskStatus.notDone
                              ? Icons.check_box_outline_blank
                              : Icons.check_box,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _toggleTaskStatus(task);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
