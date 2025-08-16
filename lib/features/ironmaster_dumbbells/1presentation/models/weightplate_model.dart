import 'package:flutter/material.dart';

////////////////////////////////////
// WeightRackStruct
////////////////////////////////////
class WeightRackStruct {
  String name;
  bool ownIt;
  double weight;
  int numOwned;

  //**********************************************/
  // Constructor
  //**********************************************/
  WeightRackStruct(
      {required this.name, //: "55lb",
      required this.ownIt, //: false,
      required this.weight, //: 55,
      required this.numOwned //: 2,
      });

  // Fetching data from Firestore as JSON (key:value pair map).
  factory WeightRackStruct.fromMap(Map data) {
    return WeightRackStruct(
      name: data['name'] ?? "0lb",
      ownIt: data['ownIt'] ?? false,
      weight: data['weight'] ?? 0,
      numOwned: data['numOwned'] ?? 0,
    );
  }
}

class WeightPlatesItemClass {
  String name = '';
  bool ownIt = false;
  double weight = 0;
  int numOwned = 0;
  int usedCount =
      0; // Calculated at runtime, the number of this plate loaded on barbell.
  bool plateAdded = false; // Plate added by user in the loadbarbell view.
  bool plateRemoved = false; // Plate removed by user in the loadbarbell view.
  // Padding added after the name field to align
  // the TextField boxes for weight and numOwned fields.
  double padding = 0;
  Color color = Colors.transparent;

  // Used for hiding and showing main menu when TextField changes focus.
  bool menuHiddenOnSubmitted = false;
  // BuildContext context;

  final TextEditingController enterWeightTextEditController =
      TextEditingController();
  final TextEditingController enterNumOwnedTextEditController =
      TextEditingController();

  final FocusNode myFocusNode = FocusNode();

  WeightPlatesItemClass({
    required this.name,
    required this.ownIt,
    required this.weight,
    required this.numOwned,
    required this.usedCount,
    required this.plateAdded,
    required this.plateRemoved,
    required this.padding,
    required this.color,
    required this.menuHiddenOnSubmitted,
  }) {
    name = name;
    ownIt = ownIt; // Checkbox
    weight = weight;
    numOwned = numOwned; // NUmber of this weight plate owned.
    usedCount =
        usedCount; // Calculated at runtime, the number of this weight loaded on barbell.
    plateAdded = plateAdded;
    plateRemoved = plateRemoved;
    padding = padding;
    color = color;
    menuHiddenOnSubmitted = menuHiddenOnSubmitted;
  }
}
