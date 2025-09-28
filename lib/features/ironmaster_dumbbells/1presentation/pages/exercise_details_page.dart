// lib/exercise_details_page.dart
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/loadbarbell_view.dart';
import 'package:flutter/material.dart';

class ExerciseDetailsPage extends StatefulWidget {
  final dynamic exercise; // Pass the selected exercise data

  const ExerciseDetailsPage({Key? key, required this.exercise})
      : super(key: key);

  @override
  _ExerciseDetailsPageState createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
  List<SetData> sets = [];

  @override
  void initState() {
    super.initState();
    // Initialize with at least one set
    addSet();
  }

  void addSet() {
    setState(() {
      sets.add(SetData());
    });
  }

  void removeSet(int index) {
    setState(() {
      sets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise['name'] ??
            'Exercise Details'), // Display exercise name
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type: ${widget.exercise['type'] ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Difficulty: ${widget.exercise['difficulty'] ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sets:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Header Row
            IntrinsicWidth(
              child: Row(
                children: const [
                  SizedBox(
                      width: 75,
                      child: Text('Sets',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 75,
                      child: Text('Weight',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 75,
                      child: Text('Reps',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 75,
                      child: Icon(
                        Icons.check,
                        size: 16,
                      )), // Header for checkbox
                  // child: Text('Done',
                  //     style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sets.length,
                itemBuilder: (context, index) {
                  return SetRow(
                    setData: sets[index],
                    setNumber: index + 1, // Pass the set number
                    onChanged: (newData) {
                      setState(() {
                        sets[index] = newData;
                      });
                    },
                    onRemove: () => removeSet(index),
                    isFirst: index == 0,
                    isLast: index == sets.length - 1,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addSet();
              },
              child: const Text('Add Set'),
            ),
            const SizedBox(height: 20), // Add some space before the button
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoadBarbellView()), // Your home page widget
                );
              },
              child: const Text('Workout Complete'),
            ),
          ],
        ),
      ),
    );
  }
}

class SetData {
  int weight = 0;
  // double weight = 0.0;
  int reps = 0;
  bool completed = false;
}

class SetRow extends StatefulWidget {
  final SetData setData;
  final int setNumber; // Add set number to constructor
  final Function(SetData) onChanged;
  final VoidCallback onRemove;
  final bool isFirst;
  final bool isLast;

  const SetRow({
    Key? key,
    required this.setData,
    required this.setNumber,
    required this.onChanged,
    required this.onRemove,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController.text = widget.setData.weight.toString();
    _repsController.text = widget.setData.reps.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 75,
            child: Text(widget.setNumber.toString())), // Display set number
        SizedBox(
          width: 75,
          child: TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            // decoration: const InputDecoration(labelText: 'Weight'),
            onChanged: (value) {
              setState(() {
                widget.setData.weight = int.tryParse(value) ?? 0;
                // widget.setData.weight = double.tryParse(value) ?? 0.0;
                widget.onChanged(widget.setData);
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 75,
          child: TextField(
            controller: _repsController,
            keyboardType: TextInputType.number,
            // decoration: const InputDecoration(labelText: 'Reps'),
            onChanged: (value) {
              setState(() {
                widget.setData.reps = int.tryParse(value) ?? 0;
                widget.onChanged(widget.setData);
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: widget.setData.completed,
                onChanged: (newValue) {
                  setState(() {
                    widget.setData.completed = newValue ?? false;
                    widget.onChanged(widget.setData);
                  });
                },
              ),
              // const Text('Completed'),
            ],
          ),
        ),
        Visibility(
          visible: !widget.isFirst,
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onRemove,
          ),
        ),
      ],
    );
  }
}

// // lib/exercise_details_page.dart
// import 'package:flutter/material.dart';

// class ExerciseDetailsPage extends StatefulWidget {
//   final dynamic exercise; // Pass the selected exercise data

//   const ExerciseDetailsPage({Key? key, required this.exercise})
//       : super(key: key);

//   @override
//   _ExerciseDetailsPageState createState() => _ExerciseDetailsPageState();
// }

// class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
//   List<SetData> sets = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with at least one set
//     addSet();
//   }

//   void addSet() {
//     setState(() {
//       sets.add(SetData());
//     });
//   }

//   void removeSet(int index) {
//     setState(() {
//       sets.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.exercise['name'] ??
//             'Exercise Details'), // Display exercise name
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Type: ${widget.exercise['type'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Difficulty: ${widget.exercise['difficulty'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Sets:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Header Row
//             IntrinsicWidth(
//               child: Row(
//                 children: const [
//                   SizedBox(
//                       width: 75,
//                       child: Text('Sets',
//                           style: TextStyle(fontWeight: FontWeight.bold))),
//                   SizedBox(
//                       width: 100,
//                       child: Text('Weight',
//                           style: TextStyle(fontWeight: FontWeight.bold))),
//                   SizedBox(
//                       width: 75,
//                       child: Text('Reps',
//                           style: TextStyle(fontWeight: FontWeight.bold))),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: sets.length,
//                 itemBuilder: (context, index) {
//                   return SetRow(
//                     setData: sets[index],
//                     setNumber: index + 1, // Pass the set number
//                     onChanged: (newData) {
//                       setState(() {
//                         sets[index] = newData;
//                       });
//                     },
//                     onRemove: () => removeSet(index),
//                     isFirst: index == 0,
//                     isLast: index == sets.length - 1,
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 addSet();
//               },
//               child: const Text('Add Set'),
//             ),
//             const SizedBox(height: 20), // Add some space before the button
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate back to the home page
//                 Navigator.pop(context);
//               },
//               child: const Text('Workout Complete'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SetData {
//   double weight = 0.0;
//   int reps = 0;
//   bool completed = false;
// }

// class SetRow extends StatefulWidget {
//   final SetData setData;
//   final int setNumber; // Add set number to constructor
//   final Function(SetData) onChanged;
//   final VoidCallback onRemove;
//   final bool isFirst;
//   final bool isLast;

//   const SetRow({
//     Key? key,
//     required this.setData,
//     required this.setNumber,
//     required this.onChanged,
//     required this.onRemove,
//     required this.isFirst,
//     required this.isLast,
//   }) : super(key: key);

//   @override
//   State<SetRow> createState() => _SetRowState();
// }

// class _SetRowState extends State<SetRow> {
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _repsController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _weightController.text = widget.setData.weight.toString();
//     _repsController.text = widget.setData.reps.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicWidth(
//       child: Row(
//         children: [
//           SizedBox(
//               width: 75,
//               child: Text(widget.setNumber.toString())), // Display set number
//           SizedBox(
//             width: 100,
//             child: TextField(
//               controller: _weightController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Weight'),
//               onChanged: (value) {
//                 setState(() {
//                   widget.setData.weight = double.tryParse(value) ?? 0.0;
//                   widget.onChanged(widget.setData);
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           SizedBox(
//             width: 75,
//             child: TextField(
//               controller: _repsController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Reps'),
//               onChanged: (value) {
//                 setState(() {
//                   widget.setData.reps = int.tryParse(value) ?? 0;
//                   widget.onChanged(widget.setData);
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           Checkbox(
//             value: widget.setData.completed,
//             onChanged: (newValue) {
//               setState(() {
//                 widget.setData.completed = newValue ?? false;
//                 widget.onChanged(widget.setData);
//               });
//             },
//           ),
//           Text('Completed'),
//           if (!widget.isFirst)
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: widget.onRemove,
//             ),
//         ],
//       ),
//     );
//   }
// }

// // lib/exercise_details_page.dart
// import 'package:flutter/material.dart';

// class ExerciseDetailsPage extends StatefulWidget {
//   final dynamic exercise; // Pass the selected exercise data

//   const ExerciseDetailsPage({Key? key, required this.exercise})
//       : super(key: key);

//   @override
//   _ExerciseDetailsPageState createState() => _ExerciseDetailsPageState();
// }

// class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
//   List<SetData> sets = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with at least one set
//     addSet();
//   }

//   void addSet() {
//     setState(() {
//       sets.add(SetData());
//     });
//   }

//   void removeSet(int index) {
//     setState(() {
//       sets.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.exercise['name'] ??
//             'Exercise Details'), // Display exercise name
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Type: ${widget.exercise['type'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Difficulty: ${widget.exercise['difficulty'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Sets:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Header Row
//             Row(
//               children: const [
//                 SizedBox(
//                     width: 40,
//                     child: Text('Sets',
//                         style: TextStyle(fontWeight: FontWeight.bold))),
//                 SizedBox(
//                     width: 75,
//                     child: Text('Weight',
//                         style: TextStyle(fontWeight: FontWeight.bold))),
//                 SizedBox(
//                     width: 60,
//                     child: Text('Reps',
//                         style: TextStyle(fontWeight: FontWeight.bold))),
//                 // SizedBox(
//                 //     width: 75,
//                 //     child: Text('Reps Completed',
//                 //         style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: sets.length,
//                 itemBuilder: (context, index) {
//                   return SetRow(
//                     setData: sets[index],
//                     setNumber: index + 1, // Pass the set number
//                     onChanged: (newData) {
//                       setState(() {
//                         sets[index] = newData;
//                       });
//                     },
//                     onRemove: () => removeSet(index),
//                     isFirst: index == 0,
//                     isLast: index == sets.length - 1,
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 addSet();
//               },
//               child: const Text('Add Set'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SetData {
//   double weight = 0.0;
//   int reps = 0;
//   int repsCompleted = 0; // New property for reps completed
//   bool completed = false;
// }

// class SetRow extends StatefulWidget {
//   final SetData setData;
//   final int setNumber; // Add set number to constructor
//   final Function(SetData) onChanged;
//   final VoidCallback onRemove;
//   final bool isFirst;
//   final bool isLast;

//   const SetRow({
//     Key? key,
//     required this.setData,
//     required this.setNumber,
//     required this.onChanged,
//     required this.onRemove,
//     required this.isFirst,
//     required this.isLast,
//   }) : super(key: key);

//   @override
//   State<SetRow> createState() => _SetRowState();
// }

// class _SetRowState extends State<SetRow> {
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _repsController = TextEditingController();
//   final TextEditingController _repsCompletedController =
//       TextEditingController(); // Controller for reps completed

//   @override
//   void initState() {
//     super.initState();
//     _weightController.text = widget.setData.weight.toString();
//     _repsController.text = widget.setData.reps.toString();
//     _repsCompletedController.text = widget.setData.repsCompleted
//         .toString(); // Initialize reps completed controller
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//             width: 40,
//             child: Text(widget.setNumber.toString())), // Display set number
//         SizedBox(
//           width: 75,
//           child: TextField(
//             controller: _weightController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Weight'),
//             onChanged: (value) {
//               setState(() {
//                 widget.setData.weight = double.tryParse(value) ?? 0.0;
//                 widget.onChanged(widget.setData);
//               });
//             },
//           ),
//         ),
//         const SizedBox(width: 10),
//         SizedBox(
//           width: 60,
//           child: TextField(
//             controller: _repsController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Reps'),
//             onChanged: (value) {
//               setState(() {
//                 widget.setData.reps = int.tryParse(value) ?? 0;
//                 widget.onChanged(widget.setData);
//               });
//             },
//           ),
//         ),
//         // const SizedBox(width: 10),
//         // SizedBox(
//         //   width: 75,
//         //   child: TextField(
//         //     controller: _repsCompletedController,
//         //     keyboardType: TextInputType.number,
//         //     decoration: const InputDecoration(labelText: 'Reps Completed'),
//         //     onChanged: (value) {
//         //       setState(() {
//         //         widget.setData.repsCompleted = int.tryParse(value) ?? 0;
//         //         widget.onChanged(widget.setData);
//         //       });
//         //     },
//         //   ),
//         // ),
//         const SizedBox(width: 10),
//         Checkbox(
//           value: widget.setData.completed,
//           onChanged: (newValue) {
//             setState(() {
//               widget.setData.completed = newValue ?? false;
//               widget.onChanged(widget.setData);
//             });
//           },
//         ),
//         const Text('Completed'),
//         if (!widget.isFirst)
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: widget.onRemove,
//           ),
//       ],
//     );
//   }
// }

// // lib/exercise_details_page.dart
// import 'package:flutter/material.dart';

// class ExerciseDetailsPage extends StatefulWidget {
//   final dynamic exercise; // Pass the selected exercise data

//   const ExerciseDetailsPage({Key? key, required this.exercise})
//       : super(key: key);

//   @override
//   _ExerciseDetailsPageState createState() => _ExerciseDetailsPageState();
// }

// class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
//   List<SetData> sets = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with at least one set
//     addSet();
//   }

//   void addSet() {
//     setState(() {
//       sets.add(SetData());
//     });
//   }

//   void removeSet(int index) {
//     setState(() {
//       sets.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.exercise['name'] ??
//             'Exercise Details'), // Display exercise name
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Type: ${widget.exercise['type'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Difficulty: ${widget.exercise['difficulty'] ?? 'Unknown'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Sets:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: sets.length,
//                 itemBuilder: (context, index) {
//                   return SetRow(
//                     setData: sets[index],
//                     onChanged: (newData) {
//                       setState(() {
//                         sets[index] = newData;
//                       });
//                     },
//                     onRemove: () => removeSet(index),
//                     isFirst: index == 0,
//                     isLast: index == sets.length - 1,
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 addSet();
//               },
//               child: const Text('Add Set'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SetData {
//   double weight = 0.0;
//   int reps = 0;
//   bool completed = false;
// }

// class SetRow extends StatefulWidget {
//   final SetData setData;
//   final Function(SetData) onChanged;
//   final VoidCallback onRemove;
//   final bool isFirst;
//   final bool isLast;

//   const SetRow({
//     Key? key,
//     required this.setData,
//     required this.onChanged,
//     required this.onRemove,
//     required this.isFirst,
//     required this.isLast,
//   }) : super(key: key);

//   @override
//   State<SetRow> createState() => _SetRowState();
// }

// class _SetRowState extends State<SetRow> {
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _repsController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _weightController.text = widget.setData.weight.toString();
//     _repsController.text = widget.setData.reps.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 75,
//           child: TextField(
//             controller: _weightController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Weight'),
//             onChanged: (value) {
//               setState(() {
//                 widget.setData.weight = double.tryParse(value) ?? 0.0;
//                 widget.onChanged(widget.setData);
//               });
//             },
//           ),
//         ),
//         const SizedBox(width: 10),
//         SizedBox(
//           width: 60,
//           child: TextField(
//             controller: _repsController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Reps'),
//             onChanged: (value) {
//               setState(() {
//                 widget.setData.reps = int.tryParse(value) ?? 0;
//                 widget.onChanged(widget.setData);
//               });
//             },
//           ),
//         ),
//         const SizedBox(width: 10),
//         Checkbox(
//           value: widget.setData.completed,
//           onChanged: (newValue) {
//             setState(() {
//               widget.setData.completed = newValue ?? false;
//               widget.onChanged(widget.setData);
//             });
//           },
//         ),
//         const Text('Completed'),
//         if (!widget.isFirst)
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: widget.onRemove,
//           ),
//       ],
//     );
//   }
// }
