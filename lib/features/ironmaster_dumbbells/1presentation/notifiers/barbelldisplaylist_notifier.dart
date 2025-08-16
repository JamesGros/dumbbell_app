import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/animated_barbell.dart';
import 'package:flutter/widgets.dart';

////////////////////////////////////
// Provider Change Notifier
////////////////////////////////////
class BarbellDisplayListBlocNotifier extends ChangeNotifier {
  // Global struct.
  //
  // This is the barbell and plates display list used in the LoadBarbellView and
  // AnimatedBarbell logic.  i.e.
  //
  // _LoadBarbellViewState._barbell._AnimatedBarbellState._dispayList[] of [_barbell, _platesList[0], ..., _platesList[n]]
  //
  List<Widget> _displayList = [];
  List<Widget> _displayList2 = [];

  /// Use when the App enters the loadbarbell view from Wendler/Hatch views
  /// and from the HOME menu.  Triggers the AnimatedPlates to add plates on
  /// the barbell using the function:
  ///
  ///   calculateWeightSet(_weightPlatesList, desiredWeight, barbellWeight)
  ///
  bool _changedPlates = false;

  ///
  /// Used when users add/removes plates in loadbarbel view.
  /// Trigger the AnimatedPlates to add/remove the outer plates only.
  ///
  bool _addOuterPlates = false;
  bool _removeOuterPlates = false;
  // bool _doneAddingOutrePlates = false;
  // bool _doneRemovingOuterPlates = false;

  int _lastAnimatedPlateIndex = 0;
  late AnimatedPlate _lastRemainingAnimatedPlateItem;
  late AnimatedPlate _lastAnimatedPlateItem;

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _displayList
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<Widget> get displayList => _displayList;

  // setter
  set displayList(List<Widget> data) {
    _displayList = data;
    notifyListeners();
  }

  // IRON MASTER - 2nd dumbbell
  List<Widget> get displayList2 => _displayList2;

  // setter
  set displayList2(List<Widget> data) {
    _displayList2 = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _changedPlates
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  bool get changedPlates => _changedPlates;

  // setter
  set changedPlates(bool data) {
    _changedPlates = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _addOuterPlates
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  bool get addOuterPlates => _addOuterPlates;

  // setter
  set addOuterPlates(bool data) {
    _addOuterPlates = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _removeOuterPlates
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  bool get removeOuterPlates => _removeOuterPlates;

  // setter
  set removeOuterPlates(bool data) {
    _removeOuterPlates = data;
    notifyListeners();
  }

  // ///////////////////////////////////////////////////////////////////////////
  // //
  // // getter/setter for _doneRemovingOuterPlates
  // //
  // ///////////////////////////////////////////////////////////////////////////

  // // getter
  // bool get doneRemovingOuterPlates => _doneRemovingOuterPlates;

  // // setter
  // set doneRemovingOuterPlates(bool data) {
  //   _doneRemovingOuterPlates = data;
  //   notifyListeners();
  // }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _lastAnimatedPlateIndex
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  int get lastAnimatedPlateIndex => _lastAnimatedPlateIndex;

  // setter
  set lastAnimatedPlateIndex(int data) {
    _lastAnimatedPlateIndex = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _lastRemainingAnimatedPlateItem
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  AnimatedPlate get lastRemainingAnimatedPlateItem =>
      _lastRemainingAnimatedPlateItem;

  // setter
  set lastRemainingAnimatedPlateItem(AnimatedPlate data) {
    _lastRemainingAnimatedPlateItem = data;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _lastAnimatedPlateItem
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  AnimatedPlate get lastAnimatedPlateItem => _lastAnimatedPlateItem;

  // setter
  set lastAnimatedPlateItem(AnimatedPlate data) {
    _lastAnimatedPlateItem = data;
    notifyListeners();
  }
}
