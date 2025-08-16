import 'package:flutter/widgets.dart';

// ///
// /// FilledStacks
// ///
// import 'package:pexlapp/models/alert_request.dart';
// import 'locator.dart';
// import 'services/dialog_service.dart';

enum MainMeuWorkoutsEnum {
  // HOME, // Displays the past workouts card flipper.
  // WENDLER,
  // HATCH,
  // CROSSFIT,
  LOADBAR,
  // WEIGHTRACK,
  // SETTINGS
}

class MenuNotifier with ChangeNotifier {
  // Page Selected state.
  MainMeuWorkoutsEnum _pageSelected =
      MainMeuWorkoutsEnum.LOADBAR; ////WEIGHTRACK; //HOME;
  MainMeuWorkoutsEnum _previousPage = MainMeuWorkoutsEnum.LOADBAR;

  MainMeuWorkoutsEnum get statePageSelected => _pageSelected;
  MainMeuWorkoutsEnum get statePreviousPage => _previousPage;

  set statePageSelected(MainMeuWorkoutsEnum newValue) {
    _previousPage = _pageSelected;
    _pageSelected = newValue;
    notifyListeners();
  }

  set statePreviousPage(MainMeuWorkoutsEnum newValue) {
    // _previousPage = _pageSelected;
    _previousPage = newValue;
    notifyListeners();
  }

  // Hide Menu state.
  bool _stateHideMenu = false;

  bool get stateHideMenu => _stateHideMenu;

  set stateHideMenu(bool newValue) {
    _stateHideMenu = newValue;
    notifyListeners();
  }

  ///
  /// Toggles the main logd cards display from a list of workout cards to
  /// a single workout card view
  /// .
  bool _mainPageLogsListViewMode = true;
  bool get mainPageLogsMultiViewMode => _mainPageLogsListViewMode;
  set mainPageLogsMultiViewMode(bool newValue) {
    _mainPageLogsListViewMode = newValue;
    notifyListeners();
  }
}
