import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/screens/home_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  String _endTime = DateFormat(
    "hh:mm a",
  ).format(DateTime.now().add(const Duration(minutes: 15)));
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF4e5ae8),
            size: 20,
          ),
        ),
        title: const Text(
          "Add Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                "Title",
                "Enter title here",
                controller: _titleController,
              ),
              _buildInputField(
                "Note",
                "Enter note here",
                controller: _noteController,
              ),
              _buildInputField(
                "Date",
                DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: _showDatePicker,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      "Start Time",
                      _startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () => _showTimePicker(isStartTime: true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      "End Time",
                      _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () => _showTimePicker(isStartTime: false),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                "Color",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildColorPalette(),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isNotEmpty &&
                          _noteController.text.isNotEmpty) {
                        Task newTask = Task(
                          title: _titleController.text,
                          description: _noteController.text,
                          startTime: _startTime,
                          endTime: _endTime,
                          color: _selectedColor == 0
                              ? const Color(0xFF4e5ae8)
                              : _selectedColor == 1
                              ? const Color(0xFFff4667)
                              : const Color.fromARGB(255, 113, 233, 97),
                        );
                        Navigator.pop(context, newTask);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Title and Note are required!"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4e5ae8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      "Create Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String title,
    String hint, {
    TextEditingController? controller,
    Widget? widget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 52,
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          padding: const EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget != null,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              if (widget != null) widget,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPalette() {
    return Row(
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = index),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? const Color(0xFF4e5ae8)
                  : index == 1
                  ? const Color(0xFFff4667)
                  : const Color(0xFFffdf19),
              child: _selectedColor == index
                  ? const Icon(Icons.done, color: Colors.white, size: 16)
                  : null,
            ),
          ),
        );
      }),
    );
  }

  _showDatePicker() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (picker != null) setState(() => _selectedDate = picker);
  }

  _showTimePicker({required bool isStartTime}) async {
    TimeOfDay? picker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picker != null) {
      String formattedTime = picker.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = formattedTime;
        } else {
          _endTime = formattedTime;
        }
      });
    }
  }
}
