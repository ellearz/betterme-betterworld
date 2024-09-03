import 'package:betterme/tree_progress.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final TextEditingController _goalsNameController = TextEditingController();
  int _selectedDuration = 21;
  List<bool> _progress = [];
  Box? _goalsBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    _goalsBox = Hive.box('goalsBox');
    _loadGoalsData();
  }

  void _loadGoalsData() {
    String? goalsName = _goalsBox?.get('goalsName');
    int? duration = _goalsBox?.get('duration');
    List? progressList = _goalsBox?.get('progress');

    setState(() {
      if (goalsName != null) _goalsNameController.text = goalsName;
      if (duration != null) _selectedDuration = duration;
      if (progressList != null) {
        _progress = List<bool>.from(progressList);
      }else {
        _progress = List<bool>.filled(_selectedDuration,false);
      }
    });

  }
  void _saveGoalsData() {
    _goalsBox?.put('goalsName', _goalsNameController.text);
    _goalsBox?.put('duration', _selectedDuration);
    _goalsBox?.put('progress', _progress);
  }

  void _resetGoals() {
    setState(() {
      _goalsNameController.clear();
      _selectedDuration = 21;
      _progress = List<bool>.filled(_selectedDuration,false);
    });
    _goalsBox?.clear();
  }

  void _toggleDay(int index) {
    setState(() {
      _progress[index]= !_progress[index];
    });
    _saveGoalsData();
  }

  void _updateDuration(int? newDuration) {
    if (newDuration != null) {
      setState(() {
        _selectedDuration = newDuration;
        _progress = List<bool>.filled(_selectedDuration,false);
      });
      _saveGoalsData();
    }
  }

Widget _buildProgressGrid() {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: _selectedDuration,
    gridDelegate: 
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => _toggleDay(index),
        child: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: _progress[index]? Colors.green:Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              'Day ${index +1}',
              style: TextStyle(
                color: _progress[index] ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    );
}
Widget _buildCompletionStatus() {
  int completedDays = _progress.where((day)=>day).length;
  double completionPercentage = 
  (completedDays/_selectedDuration)*100;

  return Column(
    children: [
      Text(
        'Completion: $completedDays/$_selectedDuration days',
        style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),

      ),
      const SizedBox(height: 10.0),
      LinearProgressIndicator(
        value: completedDays/_selectedDuration,
        backgroundColor: Colors.grey,
        color: Colors.green,
        minHeight: 10.0,
      ),
      const SizedBox(height: 10.0),
      Text(
        '${completionPercentage.toStringAsFixed(1)}% Completed',
        style: const TextStyle(fontSize: 16.0),
      )
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals Tracker'),
        actions: [
          IconButton(
            onPressed: _resetGoals, 
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Goal',
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalsNameController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _saveGoalsData(),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text(
                  'Select Duration: ',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(width: 20.0),
                DropdownButton<int>(
                  items: [7, 14, 21, 30]
                  .map(
                    (duration) => DropdownMenuItem(
                      value: duration,
                      child: Text('$duration days'),
                      ),
                  )
                  .toList(),
                  onChanged: _updateDuration,
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildProgressGrid(),
            ),
            _buildCompletionStatus(),
            TreeProgress(valueSlider: progress),
          ],
        ),
      ),
    );
  }
}
  
  
