import 'package:flutter/material.dart';

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
