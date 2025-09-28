// lib/exercise_details_page.dart
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/loadbarbell_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/loadbarbell_view.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseDetailsWidget extends StatefulWidget {
  final dynamic exercise; // Pass the selected exercise data

  const ExerciseDetailsWidget({Key? key, required this.exercise})
      : super(key: key);

  @override
  _ExerciseDetailsWidgetState createState() => _ExerciseDetailsWidgetState();
}

class _ExerciseDetailsWidgetState extends State<ExerciseDetailsWidget> {
  List<SetData> sets = [];
  final ScrollController _scrollController = ScrollController(); // Added

  @override
  void initState() {
    super.initState();
    // Initialize with at least one set
    addSet();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Added
    super.dispose();
  }

  void addSet() {
    setState(() {
      sets.add(SetData());
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //Added
    //   _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeOut,
    //   );
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_scrollController.position.maxScrollExtent > 0) {
    //     _scrollController.animateTo(
    //       _scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });
  }

  void removeSet(int index) {
    setState(() {
      sets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Type: ${widget.exercise.type ?? 'Unknown'}',
          //   style: const TextStyle(fontSize: 16),
          // ),
          // Text(
          //   'Difficulty: ${widget.exercise.difficulty ?? 'Unknown'}',
          //   style: const TextStyle(fontSize: 16),
          // ),
          // const SizedBox(height: 20),
          // const Text(
          //   'Sets:',
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          Row(
            children: [
              FloatingActionButton.small(
                onPressed: () {
                  addSet();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    //Added
                    print("_scrollController.position.maxScrollExtent= " +
                        _scrollController.position.maxScrollExtent.toString());
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add Set',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // const SizedBox(width: 10),
              // Text(
              //     "Current Weight: ${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeight).floor()}"),
              // const SizedBox(width: 5),
              // Text(((Provider.of<WeightRackBlocNotifier>(context, listen: false)
              //                 .kiloPoundsSelectionSwitch
              //                 .isSwitchedOn ==
              //             false) ||
              //         Provider.of<WeightRackBlocNotifier>(context,
              //                     listen: false)
              //                 .isMoJeerDumbbellSet ==
              //             true)
              //     ? "kg"
              //     : "lb"),
            ],
          ),
          const SizedBox(height: 10),
          IntrinsicWidth(
            child: Row(
              children: [
                const SizedBox(
                    width: 50,
                    child: Text('Set',
                        style: TextStyle(fontWeight: FontWeight.bold))),

                const SizedBox(
                    width: 120,
                    child: Text('Weight',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(
                    width: 90,
                    child: Text('Reps',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(
                    width: 65,
                    child: Icon(
                      Icons.check,
                      size: 16,
                    )), // Header for checkbox
                // child: Text('Done',
                //     style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Header Row
          // Row(
          //   children: const [
          //     SizedBox(
          //         width: 75,
          //         child: Text('Sets',
          //             style: TextStyle(fontWeight: FontWeight.bold))),
          //     SizedBox(
          //         width: 100,
          //         child: Text('Weight',
          //             style: TextStyle(fontWeight: FontWeight.bold))),
          //     SizedBox(
          //         width: 75,
          //         child: Text('Reps',
          //             style: TextStyle(fontWeight: FontWeight.bold))),
          //   ],
          // ),
          // SizedBox(
          //   width: 400,
          //   height: 300,
          //   child:
          // Flex(
          //   direction: Axis.vertical,
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //   Flexible(
          // child:

          ///
          /// Had to wrap ListView in Expanded to fix RenderFlex overflow error.
          /// And had to add Expanded inside a SizedBox to give SizedBox a height to make Expanded work.
          ///
          // Expanded(
          //   child:
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: ListView.builder(
              controller: _scrollController, // Added
              shrinkWrap: true,
              itemCount: sets.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SetRow(
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
                    // isFirstUnchecked:
                  ),
                );
              },
            ),
          ),
          // ),
          // ),
          //   ],
          // ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     addSet();
          //   },
          //   child: const Text('Add Set'),
          // ),
          // const SizedBox(height: 20), // Add some space before the button
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigate back to the home page
          //     // Navigator.pop(context);
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       LoadBarbellView.route(),
          //       // BlogPage.route(),
          //       (route) => false,
          //     );
          //   },
          //   child: const Text('Workout Complete'),
          // ),
        ],
      ),
    );
  }
}

class SetData {
  double weight = 0.0;
  int reps = 0;
  bool completed = false;
  int weightUsedWhenComplete = 0;
}

class SetRow extends StatefulWidget {
  final SetData setData;
  final int setNumber; // Add set number to constructor
  final Function(SetData) onChanged;
  final VoidCallback onRemove;
  final bool isFirst;
  final bool isLast;

  SetRow({
    Key? key,
    required this.setData,
    required this.setNumber,
    required this.onChanged,
    required this.onRemove,
    required this.isFirst,
    required this.isLast,
    // this.weightUsedWhenComplete = 0,
  }) : super(key: key);

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  // final TextEditingController _controller = TextEditingController();
  bool _isKeyboardVisible = false;

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _focusNode.hasFocus;
      Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
          .isKeyboardVisible = _isKeyboardVisible;
    });
  }

  Text _getWeightUsedWhenCompleted(BuildContext context) {
    return Text(
      ((widget.setData.completed)
          ? widget.setData.weightUsedWhenComplete.toString()
          : "${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeight).floor()}"),
      style: TextStyle(
        color: Theme.of(context)
            .textSelectionTheme
            .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _getWeightUsedWhenCompletedAltNetric(BuildContext context) {
    final CommonSwitchClass metricSwitch = Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).kiloPoundsSelectionSwitch;

    if (widget.setData.completed) {
      if (((metricSwitch.isSwitchedOn == false) ||
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
                  .isMoJeerDumbbellSet ==
              true)) {
        int inLbs = (widget.setData.weightUsedWhenComplete * 2.20462).floor();
        return Text(
          " (${inLbs.toString()}lbs)",
        );
      } else {
        int inKilos = (widget.setData.weightUsedWhenComplete / 2.20462).floor();
        return Text(
          " (${inKilos.toString()}kg)",
        );
      }
    } else {
      // Set Not completed
      return Text(
        (((metricSwitch.isSwitchedOn == false) ||
                Provider.of<WeightRackBlocNotifier>(context, listen: false)
                        .isMoJeerDumbbellSet ==
                    true))
            ? " (${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeightLbs).floor()}lbs)"
            : " (${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeightKg).floor()}kg)",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _weightController.text = widget.setData.weight.toString();
    _repsController.text = widget.setData.reps.toString();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    // _controller.dispose();
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CommonSwitchClass metricSwitch = Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).kiloPoundsSelectionSwitch;

    return Padding(
      padding: EdgeInsets.all(2), //EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              child: Text(widget.setNumber.toString())), // Display set number
          SizedBox(
            width: 100,
            child: Row(
              children: [
                _getWeightUsedWhenCompleted(context),
                Text(
                  ((metricSwitch.isSwitchedOn == false) ||
                          Provider.of<WeightRackBlocNotifier>(context,
                                      listen: false)
                                  .isMoJeerDumbbellSet ==
                              true)
                      ? "kg"
                      : "lb",
                  style: TextStyle(
                    color: Theme.of(context)
                        .textSelectionTheme
                        .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _getWeightUsedWhenCompletedAltNetric(context),
              ],
            ),

            // TextField(
            //   controller: _weightController,
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(labelText: 'Weight'),
            //   onChanged: (value) {
            //     setState(() {
            //       widget.setData.weight = double.tryParse(value) ?? 0.0;
            //       widget.onChanged(widget.setData);
            //     });
            //   },
            // ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                CustomTextField(
                  hintText: '0',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  focusNode: _focusNode,
                  onSubmitted: (value) {
                    setState(() {
                      widget.setData.reps = int.tryParse(value) ?? 0;
                      widget.onChanged(widget.setData);
                    });

                    // print('Name submitted: $value');
                    FocusScope.of(context).unfocus(); // Close keyboard
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter reps';
                    }
                    return null;
                  },
                  inputFormatters: [DoneOnSubmit()], // Use the custom formatter
                ),
              ],
            ),
            // TextField(
            //   controller: _repsController,
            //   keyboardType: TextInputType.numberWithOptions(
            //       decimal: false), //TextInputType.number,
            //   decoration: const InputDecoration(labelText: 'Reps'),
            //   onChanged: (value) {
            //     setState(() {
            //       widget.setData.reps = int.tryParse(value) ?? 0;
            //       widget.onChanged(widget.setData);
            //     });
            //   },
            // ),
          ),
          // const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: widget.setData.completed,
                onChanged: (newValue) {
                  setState(() {
                    widget.setData.completed = newValue ?? false;
                    widget.onChanged(widget.setData);
                    if (widget.setData.completed == true) {
                      widget.setData.weightUsedWhenComplete =
                          (Provider.of<WeightRackBlocNotifier>(context,
                                      listen: false)
                                  .totalPlatesWeight)
                              .floor();
                    }
                  });
                },
              ),
              // const Text('Completed'),
            ],
          ),
          Visibility(
            visible: !widget.isFirst,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
                    .isKeyboardVisible) {
                  FocusScope.of(context).unfocus(); // Dismiss keyboard
                  Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
                      .isKeyboardVisible = false;
                }

                widget.onRemove();
              },
              // } widget.onRemove,
            ),
          ),
        ],
      ),
    );
  }
}
