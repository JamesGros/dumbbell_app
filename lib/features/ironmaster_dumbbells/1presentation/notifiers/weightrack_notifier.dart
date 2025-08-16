// ignore_for_file: constant_identifier_names

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/ironmaster_selection_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/weightplate_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:provider/provider.dart';
// import 'package:pexlapp/common/commonswitch.dart';

const double POUNDS2KILO_FACTOR = 2.2046;

////////////////////////////////////
// Provider Change Notifier
////////////////////////////////////
class WeightRackBlocNotifier extends ChangeNotifier {
  // Global struct.
  // ScrollPercentStruct _wendlerSetTypeMenu = ScrollPercentStruct(buttonPressed: false, scrollStart: 0.0, scrollEnd: 0.0, buttonIndex: 0, numItems: 0, inMotion: false); // 5/5/5, 3/3/3, 5/3/1
  // ScrollPercentStruct _wendlerOneRepMaxMenu = ScrollPercentStruct(buttonPressed: false, scrollStart: 0.0, scrollEnd: 0.0, buttonIndex: 0, numItems: 0, inMotion: false); // Squat, Deadlift, Bench Press, etc.

  ///
  /// IRON MASTER 45 Pounds Plates
  ///
  List<WeightPlatesItemClass> _ironMaster45lbPlatesList = [
    ///
    /// IRON MASTER -
    ///   The order of this list matters, the weight calculation algorithm
    ///   searches and adds beginning from lighter weights (2.5lb) to heavier
    ///   weights (5lb) etc.
    ///
    WeightPlatesItemClass(
      name: "LockScrew2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // Color RGB of metalic silver
      color: Color.fromRGBO(192, 192, 192, 1.0), menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "5lb",
      ownIt: true,
      weight: 5,
      numOwned: 6,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),
    WeightPlatesItemClass(
      name: "2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2, // 2 x 2.5lb Plate and 2 x 2.5lb Lock Screws
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // color: Color.fromRGBO(99, 33, 33, 1.0)),
      // Color RGB of metalic bronze
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Colors.blueGrey),
      color: Colors.black, menuHiddenOnSubmitted: false,
    ),
  ];

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _ironMaster45lbPlatesList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get ironMaster45lbPlatesList =>
      _ironMaster45lbPlatesList;

  // setter
  set ironMaster45lbPlatesList(List<WeightPlatesItemClass> data) {
    _ironMaster45lbPlatesList = data;
    notifyListeners();
  }

  ///
  /// IRON MASTER 75 Pounds Plates
  ///
  List<WeightPlatesItemClass> _ironMaster75lbPlatesList = [
    ///
    /// IRON MASTER -
    ///   The order of this list matters, the weight calculation algorithm
    ///   searches and adds beginning from lighter weights (2.5lb) to heavier
    ///   weights (5lb) etc.
    ///
    WeightPlatesItemClass(
      name: "LockScrew2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // Color RGB of metalic silver
      // color: Color.fromRGBO(192, 192, 192, 1.0)),
      color: Colors.blueGrey, menuHiddenOnSubmitted: false,
    ),

    WeightPlatesItemClass(
      name: "5lb",
      ownIt: true,
      weight: 5,
      numOwned: 12,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),
    WeightPlatesItemClass(
        name: "2.5lb",
        ownIt: true,
        weight: 2.5,
        numOwned: 2, // 2 x 2.5lb Plate and 2 x 2.5lb Lock Screws
        usedCount: 0,
        plateAdded: false,
        plateRemoved: false,
        padding: 20,
        // color: Color.fromRGBO(99, 33, 33, 1.0)),
        // Color RGB of metalic bronze
        // color: Color.fromRGBO(169, 113, 66, 1.0)),
        // color: Color.fromRGBO(169, 113, 66, 1.0)),
        // color: Colors.blueGrey),
        color: Colors.black,
        menuHiddenOnSubmitted: false),
  ];

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _ironMaster75lbPlatesList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get ironMaster75lbPlatesList =>
      _ironMaster75lbPlatesList;

  // setter
  set ironMaster75lbPlatesList(List<WeightPlatesItemClass> data) {
    _ironMaster75lbPlatesList = data;
    notifyListeners();
  }

  ///
  /// IRON MASTER 120lb Plates
  ///
  List<WeightPlatesItemClass> _ironMaster120lbPlatesList = [
    ///
    /// IRON MASTER -
    ///   The order of this list matters, the weight calculation algorithm
    ///   searches and adds beginning from lighter weights (2.5lb) to heavier
    ///   weights (22.5lb, 5lb) etc.
    ///
    WeightPlatesItemClass(
      name: "LockScrew2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // Color RGB of metalic silver
      color: Color.fromRGBO(192, 192, 192, 1.0), menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "22.5lb",
      ownIt: true,
      weight: 22.5,
      numOwned: 2, // 165lb Set Includes 2 x 22.5lb plates
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black, menuHiddenOnSubmitted: false,
    ),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),
    // color: Color.fromRGBO(99, 33, 33, 1.0)),
    WeightPlatesItemClass(
        name: "5lb",
        ownIt: true,
        weight: 5,
        numOwned: 12,
        usedCount: 0,
        plateAdded: false,
        plateRemoved: false,
        padding: 20,
        color: Colors.black,
        menuHiddenOnSubmitted: false),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),

    WeightPlatesItemClass(
      name: "2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2, // 2 x 2.5lb Plate and 2 x 2.5lb Lock Screws
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // color: Color.fromRGBO(99, 33, 33, 1.0)),
      // Color RGB of metalic bronze
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Colors.blueGrey),
      color: Colors.black, menuHiddenOnSubmitted: false,
    ),
  ];

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _ironMaster120lbPlatesList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get ironMaster120lbPlatesList =>
      _ironMaster120lbPlatesList;

  // setter
  set ironMaster120lbPlatesList(List<WeightPlatesItemClass> data) {
    _ironMaster120lbPlatesList = data;
    notifyListeners();
  }

  ///
  /// IRON MASTER 165lb Plates
  ///
  List<WeightPlatesItemClass> _ironMaster165lbPlatesList = [
    ///
    /// IRON MASTER -
    ///   The order of this list matters, the weight calculation algorithm
    ///   searches and adds beginning from lighter weights (2.5lb) to heavier
    ///   weights (22.5lb, 5lb) etc.
    ///
    WeightPlatesItemClass(
        name: "LockScrew2.5lb",
        ownIt: true,
        weight: 2.5,
        numOwned: 2,
        usedCount: 0,
        plateAdded: false,
        plateRemoved: false,
        padding: 20,
        // // Color RGB of metalic silver
        // color: Color.fromRGBO(192, 192, 192, 1.0)),
        color: Colors.blueGrey,
        menuHiddenOnSubmitted: false),

    WeightPlatesItemClass(
      name: "22.5lb",
      ownIt: true,
      weight: 22.5,
      numOwned: 4, // 165lb Set Includes 4 x 22.5lb plates
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black, menuHiddenOnSubmitted: false,
    ),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),
    // color: Color.fromRGBO(99, 33, 33, 1.0)),
    WeightPlatesItemClass(
      name: "5lb",
      ownIt: true,
      weight: 5,
      numOwned: 12,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    // Color RGB of metalic bronze
    // color: Colors.blueGrey),

    WeightPlatesItemClass(
      name: "2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2, // 2 x 2.5lb Plate and 2 x 2.5lb Lock Screws
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      // color: Color.fromRGBO(99, 33, 33, 1.0)),
      // Color RGB of metalic bronze
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Color.fromRGBO(169, 113, 66, 1.0)),
      // color: Colors.blueGrey),
      color: Colors.black, menuHiddenOnSubmitted: false,
    ),
  ];

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _ironMaster165lbPlatesList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get ironMaster165lbPlatesList =>
      _ironMaster165lbPlatesList;

  // setter
  set ironMaster165lbPlatesList(List<WeightPlatesItemClass> data) {
    _ironMaster165lbPlatesList = data;
    notifyListeners();
  }

  //********************************************************** */

  bool _show22lbPlatesCheckboxAndGraphics = true;
  // getter
  bool get show22lbPlatesCheckboxAndGraphics =>
      _show22lbPlatesCheckboxAndGraphics;

  // setter
  set show22lbPlatesCheckboxAndGraphics(bool data) {
    _show22lbPlatesCheckboxAndGraphics = data;
    notifyListeners();
  }

  bool _showStrickthroughOn22lbPlate = false;
  // getter
  bool get showStrickthroughOn22lbPlate => _showStrickthroughOn22lbPlate;

  // setter
  set showStrickthroughOn22lbPlate(bool data) {
    _showStrickthroughOn22lbPlate = data;
    notifyListeners();
  }

  //********************************************************** */

  ///
  /// Dumbbell Set
  ///
  int _dumbbellSet = 3; // Index 3 maps to 165lb Set in grouped_checkbox.dart
  // int _dumbbellSet = 1; // Index 1 maps to 75lb Set in grouped_checkbox.dart

  // getter
  int get dumbbellSet => _dumbbellSet;

  // setter
  set dumbbellSet(int data) {
    _dumbbellSet = data;
    notifyListeners();
  }

  //********************************************************** */

  ///
  /// Weight Correction Value
  ///
  /// TODO:  Reset to 5.0 after DEBUGGING!
  double _weightCorrectionValue = 5.0;

  // getter
  double get weightCorrectionValue => _weightCorrectionValue;

  // setter
  set weightCorrectionValue(double data) {
    _weightCorrectionValue = data;
    notifyListeners();
  }

  //********************************************************** */

  ///
  /// Lase Selected Desired Weight Value
  ///
  double _desiredWeight = 5.0;

  // getter
  double get desiredWeight => _desiredWeight;

  // setter
  set desiredWeight(double data) {
    _desiredWeight = data;
    notifyListeners();
  }

  //********************************************************** */

  ///
  /// Currently selected Total Weight Displayed in the view.
  ///
  double _totalPlatesWeight = 5.0;

  // getter
  double get totalPlatesWeight => _totalPlatesWeight;

  // setter
  set totalPlatesWeight(double data) {
    _totalPlatesWeight = data;
    notifyListeners();
  }

  //********************************************************** */

  int _ironMasterTopViewWeightIndex = 0;

  // getter
  int get ironMasterTopViewWeightIndex => _ironMasterTopViewWeightIndex;

  // setter
  set ironMasterTopViewWeightIndex(int data) {
    _ironMasterTopViewWeightIndex = data;
    notifyListeners();
  }

  //********************************************************** */

  int _ironMasterBottomViewWeightIndex = 0;

  // getter
  int get ironMasterBottomViewWeightIndex => _ironMasterBottomViewWeightIndex;

  // setter
  set ironMasterBottomViewWeightIndex(int data) {
    _ironMasterBottomViewWeightIndex = data;
    notifyListeners();
  }

  //********************************************************** */

  int _ironMasterWeightMaxIndex = 0;

  // getter
  int get ironMasterWeightMaxIndex => _ironMasterWeightMaxIndex;

  // setter
  set ironMasterWeightMaxIndex(int data) {
    _ironMasterWeightMaxIndex = data;
    notifyListeners();
  }

  //********************************************************** */

  // int _ironMasterBottomViewWeightMaxIndex = 0;

  // // getter
  // int get ironMasterBottomViewWeightMaxIndex =>
  //     _ironMasterBottomViewWeightMaxIndex;

  // // setter
  // set ironMasterBottomViewWeightMaxIndex(int data) {
  //   _ironMasterBottomViewWeightMaxIndex = data;
  //   notifyListeners();
  // }

  //********************************************************** */

  ///
  /// Dumbbell View Mode
  ///
  bool _isDumbbellSingleView = true;

  // getter
  bool get isDumbbellSingleView => _isDumbbellSingleView;

  // setter
  set isDumbbellSingleView(bool data) {
    _isDumbbellSingleView = data;
    notifyListeners();
  }

  ///
  /// Dumbbell Rotated View Mode
  ///
  bool _isRotatedViewMode = false;

  // getter
  bool get isRotatedViewMode => _isRotatedViewMode;

  // setter
  set isRotatedViewMode(bool data) {
    _isRotatedViewMode = data;
    notifyListeners();
  }

  ///
  /// Dumbbell Set Changed Flag
  ///
  bool _useHeavy22lbPlatesBottomRight = true;

  // getter
  bool get useHeavy22lbPlatesBottomRight => _useHeavy22lbPlatesBottomRight;

  // setter
  set useHeavy22lbPlatesBottomRight(bool data) {
    _useHeavy22lbPlatesBottomRight = data;
    notifyListeners();
  }

  ///
  /// Dumbbell Set Changed Flag
  ///
  bool _useHeavy22lbPlatesTopLeft = true;

  // getter
  bool get useHeavy22lbPlatesTopLeft => _useHeavy22lbPlatesTopLeft;

  // setter
  set useHeavy22lbPlatesTopLeft(bool data) {
    _useHeavy22lbPlatesTopLeft = data;
    notifyListeners();
  }

  ///
  /// Pounds Standard Plates
  ///
  // Standard weight plates.  i.e. 45lb Plates is actually 45lb weighed.
  List<WeightPlatesItemClass> _weightPlatesStandardList = [
    WeightPlatesItemClass(
      name: "55lb",
      ownIt: false,
      weight: 55,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.red,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "45lb",
      ownIt: true,
      weight: 45,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "35lb",
      ownIt: true,
      weight: 35,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.yellow,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "25lb",
      ownIt: true,
      weight: 25,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "15lb",
      ownIt: true,
      weight: 15,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "10lb",
      ownIt: true,
      weight: 10,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "5lb",
      ownIt: true,
      weight: 5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 25,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 18,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1.25lb",
      ownIt: false,
      weight: 1.25,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 15,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
  ];

  ///
  /// Pounds Custom Plates
  ///
  // Standard weight plates.  i.e. 45lb Plates is atually 43.2lb weighed.
  List<WeightPlatesItemClass> _weightPlatesCustomList = [
    WeightPlatesItemClass(
      name: "55lb",
      ownIt: false,
      weight: 54,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.red,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "45lb",
      ownIt: true,
      weight: 44,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "35lb",
      ownIt: true,
      weight: 33,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.yellow,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "25lb",
      ownIt: true,
      weight: 24,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "15lb",
      ownIt: true,
      weight: 14,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "10lb",
      ownIt: true,
      weight: 9.8,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "5lb",
      ownIt: true,
      weight: 5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 25,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2.5lb",
      ownIt: true,
      weight: 2.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 18,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1.25lb",
      ownIt: false,
      weight: 1.25,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 15,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
  ];

  ///
  /// Kilo Standard Plates
  ///
  List<WeightPlatesItemClass> _weightKiloPlatesStandardList = [
    WeightPlatesItemClass(
      name: "25kg",
      ownIt: false,
      weight: 25,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.red,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "20kg",
      ownIt: true,
      weight: 20,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "15kg",
      ownIt: true,
      weight: 15,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.yellow,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "10kg",
      ownIt: true,
      weight: 10,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "5kg",
      ownIt: true,
      weight: 5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 35,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2.5kg",
      ownIt: true,
      weight: 2.5,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 28,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2kg",
      ownIt: true,
      weight: 2,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 25,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1.5kg",
      ownIt: true,
      weight: 1.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 28,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1kg",
      ownIt: false,
      weight: 1,
      numOwned: 2,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 28,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "0.5kg",
      ownIt: false,
      weight: 0.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 28,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
  ];

  ///
  /// Kilo Custom Plates
  ///
  List<WeightPlatesItemClass> _weightKiloPlatesCustomList = [
    WeightPlatesItemClass(
      name: "25kg",
      ownIt: false,
      weight: 25,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.red,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "20kg",
      ownIt: true,
      weight: 20,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "15kg",
      ownIt: true,
      weight: 15,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.yellow,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "10kg",
      ownIt: true,
      weight: 10,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "5kg",
      ownIt: true,
      weight: 5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 20,
      color: Colors.black,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2.5kg",
      ownIt: true,
      weight: 2.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 14,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "2kg",
      ownIt: true,
      weight: 2,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 25,
      color: Colors.blue,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1.5kg",
      ownIt: true,
      weight: 1.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 16,
      color: Colors.green,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "1kg",
      ownIt: false,
      weight: 1,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 27,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
    WeightPlatesItemClass(
      name: "0.5kg",
      ownIt: false,
      weight: 0.5,
      numOwned: 0,
      usedCount: 0,
      plateAdded: false,
      plateRemoved: false,
      padding: 16,
      color: Colors.white,
      menuHiddenOnSubmitted: false,
    ),
  ];

  ///
  /// Single instance of CommonSwitchClass for weight rack selection
  ///

  CommonSwitchClass _weightRackSelectionSwitch = CommonSwitchClass(
      title: "Weight Rack:",
      onName: "Custom",
      offName: "Standard",
      isSwitchedOn: true,
      callbackFunc: weightRackSwitchCallback);

  static void weightRackSwitchCallback(BuildContext context, bool value) {
    Provider.of<WeightRackBlocNotifier>(context, listen: false)
        ._weightRackSelectionSwitch
        .isSwitchedOn = value;
  }

  ///
  /// Single instance of CommonSwitchClass for Metric/Lbs/Kgs selection
  ///
  CommonSwitchClass _kiloPoundsSelectionSwitch = CommonSwitchClass(
      title: "Metric:",
      onName: "Kgs", // false
      offName: "Lbs", // true
      isSwitchedOn: true,
      callbackFunc: metricSwitchCallback);

  static void metricSwitchCallback(BuildContext context, bool value) {
    Provider.of<WeightRackBlocNotifier>(context, listen: false)
        ._kiloPoundsSelectionSwitch
        .isSwitchedOn = value;
  }

  // ///
  // /// Single instance of IronMasterDumbbellSetClass for weight rack selection
  // ///
  // IronMasterDumbbellSetClass _ironMasterDumbbellSetClass =
  //     IronMasterDumbbellSetClass();

  // ///////////////////////////////////////////////////////////////////////////
  // //
  // // getter/setter for _ironMasterDumbbellSetClass
  // //
  // ///////////////////////////////////////////////////////////////////////////

  // // getter
  // IronMasterDumbbellSetClass get ironMasterDumbbellSetClass =>
  //     _ironMasterDumbbellSetClass;

  // // setter
  // set ironMasterDumbbellSetClass(IronMasterDumbbellSetClass data) {
  //   _ironMasterDumbbellSetClass = data;
  //   notifyListeners();
  // }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightPlatesStandardList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get weightPlatesStandardList =>
      _weightPlatesStandardList;

  // setter
  set weightPlatesStandardList(List<WeightPlatesItemClass> data) {
    _weightPlatesStandardList = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightPlatesCustomList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get weightPlatesCustomList =>
      _weightPlatesCustomList;

  // setter
  set weightPlatesCustomList(List<WeightPlatesItemClass> data) {
    _weightPlatesCustomList = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightKiloPlatesStandardList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get weightKiloPlatesStandardList =>
      _weightKiloPlatesStandardList;

  // setter
  set weightKiloPlatesStandardList(List<WeightPlatesItemClass> data) {
    _weightKiloPlatesStandardList = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightKiloPlatesCustomList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<WeightPlatesItemClass> get weightKiloPlatesCustomList =>
      _weightKiloPlatesCustomList;

  // setter
  set weightKiloPlatesCustomList(List<WeightPlatesItemClass> data) {
    _weightKiloPlatesCustomList = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightRackSelectionSwitch
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  CommonSwitchClass get weightRackSelectionSwitch => _weightRackSelectionSwitch;

  // setter
  set weightRackSelectionSwitch(CommonSwitchClass data) {
    _weightRackSelectionSwitch = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _weightRackSelected
  //
  ///////////////////////////////////////////////////////////////////////////
  List<bool> _weightRackSelected = [true, false]; // Standard or Custom

  // getter
  List<bool> get weightRackSelected => _weightRackSelected;

  // setter
  set weightRackSelected(List<bool> data) {
    _weightRackSelected = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _kiloPoundsSelectionSwitch
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  CommonSwitchClass get kiloPoundsSelectionSwitch => _kiloPoundsSelectionSwitch;

  // setter
  set kiloPoundsSelectionSwitch(CommonSwitchClass data) {
    _kiloPoundsSelectionSwitch = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _kiloPoundsSelected
  //
  ///////////////////////////////////////////////////////////////////////////
  List<bool> _kiloPoundsSelected = [false, true]; // kg (false) or lb (true)

  // getter
  List<bool> get kiloPoundsSelected => _kiloPoundsSelected;

  // setter
  set kiloPoundsSelected(List<bool> data) {
    _kiloPoundsSelected = data;
    notifyListeners();
  }
}
