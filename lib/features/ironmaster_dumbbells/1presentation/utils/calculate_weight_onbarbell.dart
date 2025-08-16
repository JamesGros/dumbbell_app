//  JG DEBUG - Example function call of calculateWeightSet():
//
//  _weightRackSelectionSwitch.isSwitchedOn
//                       ? calculateWeightSet(_weightPlatesStandardList, 225)
//                       : calculateWeightSet(_weightPlatesCustomList, 225),
import 'dart:math';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/weightplate_model.dart';
import 'package:flutter/foundation.dart';

// Usage Information
//
// _weightRackSelectionSwitch.isSwitchedOn
//         ? calculateWeightSet(_weightPlatesStandardList, 225.0)
//         : calculateWeightSet(_weightPlatesCustomList, 225.0);
//
// After calling calculateWeightSet(_weightPlatesStandardList),
// the _weightPlatesStandardList.usedCount value indicates the number of
// plates used on 1 side of the barbell.
//
// For example, if desired weight is 315,
//
//     Calling calculateWeightSet(_weightPlatesStandardList, 315.0) yields:
//
//     weightsUsedArray[1].usedCount = 2, weight = 45.0
//     weightsUsedArray[2].usedCount = 1, weight = 35.0
//     weightsUsedArray[5].usedCount = 1, weight = 10.0
//
// This will drive the plates loading on to the barbell animation.
//
// Future<double> calculateWeightSet(List<WeightPlatesItemClass> weightsUsedArray,
// double targetWeight, double barbellWeight) async {
double calculateWeightSet(List<WeightPlatesItemClass> weightsUsedArray,
    double targetWeight, double barbellWeight) {
  // 		if (switchStr == 'custom') {
  // 	weightsUsedArray = CustomWeightsUsedArray;
  // } else {
  // 	weightsUsedArray = StandardWeightsUsedArray;
  // }

  //
  // Algorithm from the following website posting:
  //
  //   https://www.reddit.com/r/math/comments/1oxauy/loading_a_barbell/
  //
  // Number of Plates on 1 side of Barbell.
  //        |
  //        |
  // index  |
  // -----  v
  //    1   B5=MAX(0,INT(($B$1-$B$2)/(2*B4)))
  //    2   C5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2)/(2*C4)))
  //    3   D5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2)/(2*D4)))
  //    4   E5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2)/(2*E4)))
  //    5   F5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2)/(2*F4)))
  //    6   G5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2 - $F4*$F5*2)/(2*G4)))
  //    7   H5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2 - $F4*$F5*2 - $G4*$G5*2)/(2*H4)))
  //    8   I5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2 - $F4*$F5*2 - $G4*$G5*2 - $H4*$H5*2)/(2*I4)))
  //    9   J5=MAX(0,INT(($B$1-$B$2 - $B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2 - $F4*$F5*2 - $G4*$G5*2 - $H4*$H5*2 - $I4*$I5*2)/(2*J4)))
  //    Total Weight = 2*(B4*B5+C4*C5+D4*D5+E4*E5+F4*F5+G4*G5+H4*H5+I4*I5)+B2
  // Where,
  //        Column
  //          B   C   D   E   F   G   H   I   J
  // Row 1:   205 (target)
  // Row 2:   45  (barbell)
  // Row 3:
  // Row 4:   55  45	35  25	15  10	5	2.5 1.0  (Weights)
  // Row 5:   B5  C5  D5  E5  F5  G5  H5  I5  J5   (Calculated Nmber of plates)
  //

  // Example:
  // WeightPlatesItemClass(
  //       name: "55lb Plate", ownIt: false, weight: 55, numOwned: 2, usedCount: 0, padding: 5),

  targetWeight = targetWeight.ceilToDouble();

  //
  // Add user selected barbell (i.e 15, 35, or 45 lb barbells)
  //

  double targetPlatesOnly = targetWeight -
      barbellWeight; //weightsUsedArray[0].weight; // Subtract Barbell Weight
  double platesSubtotal = 0.0;
  for (var index = 0; index < weightsUsedArray.length; index++) {
    weightsUsedArray[index].usedCount = 0;
    // Only calculate with selected (i.e. owned weights) weights from the Custom Weights "Plates & Bumpers" page.
    if (weightsUsedArray[index].ownIt == true) {
      // C4, D5, ... J5

      if (targetPlatesOnly - platesSubtotal > 0) {
        double usedCount = (targetPlatesOnly - platesSubtotal) /
            (2 * weightsUsedArray[index].weight);
        // weightsUsedArray[index].usedCount = max(0, usedCount.ceil());
        weightsUsedArray[index].usedCount = max(0, usedCount.floor());
        // if (usedCount.floor() == 0) {
        //   weightsUsedArray[index].usedCount = 1;
        // }
      }

      // Check number of plates owned by user.
      if (weightsUsedArray[index].usedCount >
          (weightsUsedArray[index].numOwned / 2).floor()) {
        weightsUsedArray[index].usedCount =
            (weightsUsedArray[index].numOwned / 2).floor();
      }

      // Accumulates to ($B4*$B5*2 - $C4*$C5*2 - $D4*$D5*2 - $E4*$E5*2 - $F4*$F5*2 - $G4*$G5*2 - $H4*$H5*2 - $I4*$I5*2) from above description.
      platesSubtotal += (weightsUsedArray[index].usedCount *
          weightsUsedArray[index].weight *
          2);

      // Check if target weight have been reached.
      if (platesSubtotal >= targetPlatesOnly) {
        break;
      }
    }
  }

  // Calculate the result - total weight
  double totalWeight = 0.0;
  for (var index = 0; index < weightsUsedArray.length; index++) {
    totalWeight +=
        (weightsUsedArray[index].usedCount * weightsUsedArray[index].weight);

    // // JG DEBUG
    // if (weightsUsedArray[index].usedCount != 0) {
    //   weightsUsedArray[index].plateAdded = true;
    // }

    var usedCount = weightsUsedArray[index].usedCount;
    var weight = weightsUsedArray[index].weight;
    if (kDebugMode) {
      print(
          "weightsUsedArray[$index].usedCount = $usedCount, weight = $weight");
    }
  }
  if (kDebugMode) {
    print("BEFORE x2 totalWeight = $totalWeight");
  }

  totalWeight *=
      2; // Times 2 because weights are loaded on both side of the barbell.

  // print("AFTER x2 plus barbell totalWeight = $totalWeight");

  //
  // Add user selected barbell (i.e 15, 35, or 45 lb barbells)
  //
  totalWeight +=
      barbellWeight; //weightsUsedArray[0].weight;  // Add the barbell weight.

  totalWeight = (totalWeight).ceil().toDouble();

  if (kDebugMode) {
    print("targetWeight = $targetWeight");
    print("calculated weight = $totalWeight");
  }

  // ///
  // /// IF the calculated weight is less than threshold (e.g. +/- 5 lbs),
  // /// then make an adjustment.   The threshold +/- 5lb should be specified by
  // /// the user of the App.
  // ///
  // const double userThreshold = 5.0;
  // const double threshold = userThreshold / 2;
  // if (totalWeight != targetWeight) {
  //   ///
  //   /// Determine if NOT within threshold
  //   ///
  //   if ((totalWeight - targetWeight).abs() > threshold) {
  //     ///
  //     /// Calculate a new target weight to get closer to desired weight
  //     /// within the threshold.
  //     ///
  //     double newTargetWeight = totalWeight + userThreshold;
  //     // Recursive call here!
  //     totalWeight =
  //         calculateWeightSet(weightsUsedArray, newTargetWeight, barbellWeight);
  //   }
  // }

  return (totalWeight);
}
