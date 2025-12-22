import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/screens/add_task.dart';

class Task {
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final Color color;

  Task({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}

class HomeScreen extends StatefulWidget {
  final String userName;
  final File userImage;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildAddTaskBar(),
              const SizedBox(height: 20),
              _buildDateBar(),
              const SizedBox(height: 25),
              Expanded(
                child: tasks.isEmpty ? _buildEmptyWidget() : _buildTaskList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${widget.userName}",
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF4e5ae8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Have A Nice Day",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        CircleAvatar(radius: 26, backgroundImage: FileImage(widget.userImage)),
      ],
    );
  }

  Widget _buildAddTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const Text(
              "Today",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTask()),
            );

            if (result != null && result is Task) {
              setState(() {
                tasks.add(result);
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4e5ae8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "+ Add Task",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDateBar() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = index == 0;
          return Container(
            width: 70,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4e5ae8)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.MMM().format(date),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  DateFormat.d().format(date),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  DateFormat.E().format(date),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Complete",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.delete, color: Colors.white),
              ],
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              setState(() {
                tasks.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Task Completed!"),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              setState(() {
                tasks.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Task Deleted"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: task.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: Colors.white70,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${task.startTime} - ${task.endTime}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        task.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: 0.5,
                  color: Colors.white60,
                ),
                const RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "TODO",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.task_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "You do not have any tasks yet!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
