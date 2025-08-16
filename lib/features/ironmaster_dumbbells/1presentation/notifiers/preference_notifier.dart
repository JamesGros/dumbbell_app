import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';

class PreferenceProvider with ChangeNotifier {
  ///
  /// Preference
  ///
  final PreferenceBloc _bloc = gSharedPrefs;

  PreferenceProvider() {
    gSharedPrefs.init();
    // _bloc = PreferenceBloc();
    _bloc.loadPreferences();
  }

  PreferenceBloc get bloc => _bloc;

  // SharedPrefs get bloc => _bloc;

  ///
  /// Color Theme Switch
  ///
  CommonSwitchClass _colorThemeSwitch = CommonSwitchClass(
      title: "App Theme:",
      onName: "Dark",
      offName: "Light",
      isSwitchedOn: true,
      callbackFunc: colorThemeSwitchCallback);

  static void colorThemeSwitchCallback(BuildContext context, bool value) {
    Provider.of<PreferenceProvider>(context, listen: false)
        .colorThemeSwitch
        .isSwitchedOn = value;
    // if (value == false) {
    //   // _changeTheme(context, MyThemeKeys.BLACKTEXTORANGEBG);
    //   CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.BLACKTEXTORANGEBG);
    // } else {
    //   CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.ORANGETEXTBLACKBG);
    // }
  }

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _colorThemeSwitch
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  CommonSwitchClass get colorThemeSwitch => _colorThemeSwitch;

  // setter
  set colorThemeSwitch(CommonSwitchClass data) {
    _colorThemeSwitch = data;

    notifyListeners();
  }

  void setColorThemeSwitchithContext(
      BuildContext context, CommonSwitchClass data) {
    _colorThemeSwitch = data;
    // if (data.isSwitchedOn == false) {
    //   CustomTheme.instanceOf(context)
    //       .changeTheme(MyThemeKeys.BLACKTEXTORANGEBG);
    // } else {
    //   CustomTheme.instanceOf(context)
    //       .changeTheme(MyThemeKeys.ORANGETEXTBLACKBG);
    // }
    notifyListeners();
  }

  List<String> _colorThemeSelected = [
    "dark",
    "light"
  ]; // dark (false) or light (true)

  ///////////////////////////////////////////////////////////////////////////
  //
  // getter/setter for _colorThemeSelected
  //
  ///////////////////////////////////////////////////////////////////////////

  // getter
  List<String> get colorThemeSelected => _colorThemeSelected;

  // setter
  set colorThemeSelected(List<String> data) {
    _colorThemeSelected = data;
    notifyListeners();
  }
}
