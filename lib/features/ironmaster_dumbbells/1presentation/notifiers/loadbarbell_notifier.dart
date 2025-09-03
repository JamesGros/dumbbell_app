import 'package:flutter/widgets.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/loadbarbell_model.dart';

// import 'models/workout_model.dart';
// import 'package:pexlapp/blocs/loadbarbell_model.dart';

///
/// From SettingsPage TBD
///
///
///
///
/// 1RM values TBD
///
int gDeadlift1RM = 0;
int gBench1RM = 0;
int gShoulderPress1RM = 0;
int gBackSquat1RM = 0;
int gFrontSquat1RM = 0;

class TotalWorkingSetsStruct {
  late bool isWarmupSelected;
  late bool isBoringButBigSelected;
  late int length; // length of the ListView list.
  late int index; // index of selected item on the ListView list
  late int
      realNumberOfSets; // This is the sum of warmup, bbb, and main lift sets, minus the SAVE button.
}

////////////////////////////////////
// Provider Change Notifier
////////////////////////////////////
class LoadBarbellBlocNotifier extends ChangeNotifier {
  //
  // This is used by the LoadBarbellView's checkbox widgets
  // and the Widget that displays the "loaded barbell" details.
  //
  LoadBarbellStruct _barbell =
      LoadBarbellStruct(barbellInUse: BarbellType.BARBELL_45LB);

  ///
  /// For tracking last set between LBV and AnimatedBarbell workout
  /// stat display.
  ///
  late bool _isLastSet;
  late int _currentRepCount;

  // getter
  bool get isLastSet => _isLastSet;

  // setter
  set isLastSet(bool data) {
    _isLastSet = data;
    notifyListeners();
  }

  // getter
  int get currentRepCount => _currentRepCount;

  // setter
  set currentRepCount(int data) {
    _currentRepCount = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _currentSetText
  //
  ///////////////////////////////////////////////////////////////////////////
  ///
  /// This is the "Set #/#" text set in teh Wendler or Hatch pages,
  /// and read by the LoadBarbell page to display the current
  /// workout stats in a header widget.
  ///
  Text _currentSetText = Text("");

  // getter
  Text get currentSetText => _currentSetText;

  // setter
  set currentSetText(Text data) {
    _currentSetText = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _totalWorkingSetsInfo
  //
  ///////////////////////////////////////////////////////////////////////////
  TotalWorkingSetsStruct _totalWorkingSetsInfo = TotalWorkingSetsStruct();

  // getter
  TotalWorkingSetsStruct get totalWorkingSetsInfo => _totalWorkingSetsInfo;

  // setter
  set totalWorkingSetsInfo(TotalWorkingSetsStruct data) {
    _totalWorkingSetsInfo = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _barbell
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  LoadBarbellStruct get barbell => _barbell;

  // setter
  set barbell(LoadBarbellStruct data) {
    _barbell = data;
    notifyListeners();
  }

  // getter
  // BarbellType get barbellInUse => _barbell.barbellInUse;

  // IRON MASTER - Dumbbell handle + locking screws = 10lb
  BarbellType get barbellInUse => _barbell.barbellInUse;
  // BarbellType get barbellInUse => BarbellType.BARBELL_IRONMASTER_5lb;

  // setter
  set barbellInUse(BarbellType data) {
    _barbell.barbellInUse = data;
    notifyListeners();
  }

  // String get stateTitle => _barbell.title;
  // double get statePercent => _barbell.percent;
  // int get stateReps => _barbell.reps;
  // int get stateSet => _barbell.setNumber;
  // int get stateOneRepMax => _barbell.oneRepMax;
  // int get stateOneRepMaxHatchBackSquat => _barbell.oneRepMaxHatchBackSquat;
  // int get stateOneRepMaxHatchFrontSquat => _barbell.oneRepMaxHatchFrontSquat;
  // int get stateWendlerMovement => _barbell.wendlerMovement;
  // int get stateWendlerSetType => _barbell.wendlerSetType;
  // int get stateHatchMovement => _barbell.hatchMovement;
  // WorkoutType get stateWendlerOrHatchType => _barbell.workoutType;

  // set stateTitle(String newTitle) {
  //   _barbell.title = newTitle;
  //   notifyListeners();
  // }

  // set statePercent(double newPercent) {
  //   _barbell.percent = newPercent;
  //   notifyListeners();
  // }

  // set stateReps(int newReps) {
  //   _barbell.reps = newReps;
  //   notifyListeners();
  // }

  // set stateSet(int newSet) {
  //   _barbell.setNumber = newSet;
  //   notifyListeners();
  // }

  // set stateOneRepMax(int newOneRepMax) {
  //   _barbell.oneRepMax = newOneRepMax;
  //   notifyListeners();
  // }

  // set stateOneRepMaxHatchBackSquat(int newOneRepMax) {
  //   _barbell.oneRepMaxHatchBackSquat = newOneRepMax;
  //   notifyListeners();
  // }

  // set stateOneRepMaxHatchFrontSquat(int newOneRepMax) {
  //   _barbell.oneRepMaxHatchFrontSquat = newOneRepMax;
  //   notifyListeners();
  // }

  // set stateWendlerMovement(int value) {
  //   _barbell.wendlerMovement = value;
  //   notifyListeners();
  // }

  // set stateWendlerSetType(int value) {
  //   _barbell.wendlerSetType = value;
  //   notifyListeners();
  // }

  // set stateHatchMovement(int value) {
  //   _barbell.hatchMovement = value;
  //   notifyListeners();
  // }

  // set stateWendlerOrHatchType(WorkoutType value) {
  //   _barbell.workoutType = value;
  //   notifyListeners();
  // }

  // ///
  // /// From SettingsPage
  // ///
  // ///
  // ///
  // ///
  /// 1RM values
  ///
  int _backSquat1RM = 0;
  int _frontSquat1RM = 0;

  ///
  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _backSquat1RM
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  int get backSquat1RM => _backSquat1RM;

  // setter
  set backSquat1RM(int data) {
    _backSquat1RM = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _frontSquat1RM
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  int get frontSquat1RM => _frontSquat1RM;

  // setter
  set frontSquat1RM(int data) {
    _frontSquat1RM = data;
    notifyListeners();
  }

  int _defaultBackSquatBarbell = 0;
  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for defaultBackSquatBarbell
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  int get defaultBackSquatBarbell => _defaultBackSquatBarbell;

  // setter
  set defaultBackSquatBarbell(int data) {
    _defaultBackSquatBarbell = data;
    notifyListeners();
  }

  late String _boringButBigDropdownValue;
  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for boringButBigDropdownValue
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  String get boringButBigDropdownValue => _boringButBigDropdownValue;

  // setter
  set boringButBigDropdownValue(String data) {
    _boringButBigDropdownValue = data;
    notifyListeners();
  }
}
