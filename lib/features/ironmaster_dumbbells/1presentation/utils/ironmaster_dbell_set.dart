// ignore_for_file: dead_code

import 'dart:convert';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/show_picker_dialog_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gGetIronMasterDumbbellSetMaxIndex(BuildContext context) {
  switch (
      Provider.of<WeightRackBlocNotifier>(context, listen: false).dumbbellSet) {
    case 0:
      List<dynamic> theList = JsonDecoder().convert(gGetCurrent45lbWeightList(
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue));
      return theList[0].length;
    case 1:
      List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue));
      return theList[0].length;
    case 2:
      List<dynamic> theList = JsonDecoder().convert(gGetCurrent120lbWeightList(
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue));
      return theList[0].length;
    case 3:
      List<dynamic> theList = JsonDecoder().convert(gGetCurrent165lbWeightList(
          context,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue));
      return theList[0].length;
    default:
      List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue));
      return theList[0].length;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gGetDumbbellSetIndex(String name) {
  switch (name) {
    case "45lb Set":
      return 0;
    case "75lb Set":
      return 1;
    case "120lb Set":
      return 2;
    case "165lb Set":
      return 3;
    default:
      return 0;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:
///
/////////////////////////////////////////////////////////////////////////////////////////////////
String gGetDumbbellSetString(int index) {
  switch (index) {
    case 0:
      return "45lb Dumbbell Set";
    case 1:
      return "75lb Dumbbell Set";
    case 2:
      return "120lb Dumbbell Set";
    case 3:
      return "165lb Dumbbell Set";
    default:
      return "45lb Dumbbell Set";
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gGetCurrent45lbWeightList
///
/////////////////////////////////////////////////////////////////////////////////////////////////
String gGetCurrent45lbWeightList(double real5lbWeight) {
  ///
  /// Create a list of plates increasing in weight.
  /// This is converted to jSon format
  ///
  List<dynamic> weightList = [5, 10, 15];
  const int TOTAL_5LB_PLATES_PER_DUMBBELL = 3;
  for (double i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL; ++i) {
    double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

    weightList.add(formatedWeight.ceil()); //.toDouble());
    weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
  }

  ///
  /// Use jsonEncode() function to create the Picker Data List.
  ///
  return "[" + jsonEncode(weightList) + "]";
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gGetCurrent75lbWeightList
///
/////////////////////////////////////////////////////////////////////////////////////////////////
String gGetCurrent75lbWeightList(double real5lbWeight) {
  ///
  /// Create a list of plates increasing in weight.
  /// This is converted to jSon format
  ///
  List<dynamic> weightList = [5, 10, 15];
  const int TOTAL_5LB_PLATES_PER_DUMBBELL = 6;
  for (double i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL; ++i) {
    // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
    // double fraction = formatedWeight - formatedWeight.truncate();
    // if (fraction < 0.5) {
    //   weightList.add(formatedWeight.floor());
    //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
    //   // when using 5 instead of (2.5 * 2)
    //   weightList.add(formatedWeight.floor() + (5));
    // } else {
    //   weightList.add(formatedWeight.ceil().round());
    //   // 5lb is the 2.5lb plates x 2, dart formats fractions to "5"
    //   // when using 5, but formats to "5.0" if using (2.5 * 2).
    //   weightList.add(formatedWeight.ceil().round() + (5));
    // }

    double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

    weightList.add(formatedWeight.ceil()); //.toDouble());
    weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
  }

  ///
  /// Use jsonEncode() function to create the Picker Data List.
  ///
  return "[" + jsonEncode(weightList) + "]";
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gGetCurrent120lbWeightList
///
/////////////////////////////////////////////////////////////////////////////////////////////////
String gGetCurrent120lbWeightList(double real5lbWeight) {
  ///
  /// Create a list of plates increasing in weight.
  /// This is converted to jSon format
  ///
  List<dynamic> weightList = [5, 10, 15];
  const int TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE = 6;
  double currentWeight = 15.0;

  for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE; ++i) {
    double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

    weightList.add(formatedWeight.ceil()); //.toDouble());
    weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
    currentWeight += (real5lbWeight * 2);
    currentWeight = currentWeight.ceilToDouble();
  }

  ///
  /// 120lb Set comes with two 22.5 plates per dunbbell..
  ///
  double maxWeight = 15.0 +
      (2 * 22.5) +
      (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));
  while (currentWeight < maxWeight) {
    currentWeight += real5lbWeight;

    weightList.add(currentWeight.toInt()); //.round());
    // weightList.add(currentWeight.ceil().round());
  }

  ///
  /// Use jsonEncode() function to create the Picker Data List.
  ///
  return "[" + jsonEncode(weightList) + "]";
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gGetCurrent165lbWeightList
///
/// When 22.5lb checkbox plate NOT selected:
/// [5, 10, 15, 20, 25, 29, 34, 38, 43, 47, 52, 56, 61, 66, 71, 80, 85, 89, 94, 98, 103, 108, 112, 117, 121, 126, 131, 135, 140, 144, 149, 154, 158, 163]
///
/// When 22.5lb checkbox plate selected:
/// [5, 10, 15, 20, 25, 29, 34, 39, 43, 48, 52, 57, 62, 66, 71, 93, 116, 138, 161]
///
/////////////////////////////////////////////////////////////////////////////////////////////////
String gGetCurrent165lbWeightList(BuildContext context, double real5lbWeight) {
  ///
  /// Create a list of plates increasing in weight.
  /// This is converted to jSon format
  ///
  List<dynamic> weightList = [5, 10, 15];
  const int TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE = 6;
  //show22lbPlatesCheckboxAndGraphics = true;
  if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
          .useHeavy22lbPlatesBottomRight ==
      false) {
    double currentWeight = 15.0;

    for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE; ++i) {
      double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

      weightList.add(formatedWeight.ceil()); //.toDouble());
      weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
      currentWeight += (real5lbWeight * 2);
      currentWeight = currentWeight.ceilToDouble();
    }

    ///
    /// 165lb Set comes with four 22.5 plates per dunbbell..
    ///
    double maxWeight = 15.0 +
        (4 * 22.5) +
        (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));
    while (currentWeight < maxWeight) {
      currentWeight += real5lbWeight;
      // currentWeight = currentWeight.ceilToDouble();

      weightList.add(currentWeight.ceil());
    }
    if (kDebugMode) {
      print("22.5lb NOT CHECKED weightList[] = $weightList");
    }
  } else {
    ///
    /// To get list of ALL possible weight combinations,
    /// when 22.5lb checkbox is checked, then iterate:
    /// 1. With all 5lb plates. - Until < 55lb
    /// 2. With 22.5lb plate pair + 5lb plates
    /// 3. With 2 x 22.5lb plate pair + 5lb plates
    ///

    ///
    /// 165lb Set comes with four 22.5 plates per dunbbell..
    ///
    double currentWeight = 15.0;

    double maxWeight = currentWeight +
        (4 * 22.5) +
        (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));

    // Add 4.5lb / 5lb Plates
    int add5lbPlateCount = 0;
    while (add5lbPlateCount < TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2) {
      currentWeight += real5lbWeight;
      // currentWeight = currentWeight.ceilToDouble();
      add5lbPlateCount++;

      weightList.add(currentWeight.ceil());
    }

    // Add 22.5lb plates
    int add22p5PlateCount = 0;
    while (add22p5PlateCount < 4) {
      currentWeight += 22.5;
      add22p5PlateCount++;
      weightList.add(currentWeight.ceil());
    }

    if (kDebugMode) {
      print("22.5lb CHECKED weightList[] = $weightList");
    }
  }

  ///
  /// Use jsonEncode() function to create the Picker Data List.
  ///
  return "[" + jsonEncode(weightList) + "]";
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function: _getIronMasterWeightIndex
///
///   Returns the weight index for the IronMaster dumbbell set
///   based on the weight and the dumbbell set.
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gGetIronMasterWeightIndex(BuildContext context, int weight) {
  switch (
      Provider.of<WeightRackBlocNotifier>(context, listen: false).dumbbellSet) {
    case 0:
      return gIronMaster45LbWeightIndexFromPicker2(
          weight,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue);
      break;
    case 1:
      return gIronMaster75LbWeightIndexFromPicker2(
          weight,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue);
      break;
    case 2:
      return gIronMaster120LbWeightIndexFromPicker2(
          weight,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue);
      break;
    case 3:
      return gIronMaster165LbWeightIndexFromPicker2(
          context,
          weight,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue);
      break;
    default:
      return gIronMaster45LbWeightIndexFromPicker2(
          weight,
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue);
      break;
  }
  // return 0;
}
