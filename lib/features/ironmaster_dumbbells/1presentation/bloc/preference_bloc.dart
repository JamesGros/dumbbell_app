import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/color_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';

///
/// Global
///
final gSharedPrefs = PreferenceBloc();

class PreferenceBloc {
  static SharedPreferences? _sharedPrefs;
  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  final _brightness = BehaviorSubject<Brightness>();
  final _primaryColor = BehaviorSubject<ColorModel>();
  // final _oneRepMaxes = BehaviorSubject<OneRepMaxModel>();
  final _colors = [
    ColorModel(color: Colors.blue, index: 0.0, name: 'Blue'),
    ColorModel(color: Colors.green, index: 1.0, name: 'Green'),
    ColorModel(color: Colors.red, index: 2.0, name: 'Red'),
    ColorModel(color: Colors.white, index: 3.0, name: 'White'),
  ];

  final _ironMasterDumbbellSetItem = BehaviorSubject<int>();
  final _weighed5lbPlateItem = BehaviorSubject<double>();
  final _desiredWeightItem = BehaviorSubject<double>();
  final _dumbbellMetricInPoundsItem = BehaviorSubject<bool>();

  static const String keyDumbbellSetChoice = 'dumbbellSetChoice';
  static const String keyWeighed5lbPlate = 'weighed5lbplate';
  static const String keyDesiredWeight = 'desiredWeight';
  static const String keyDumbbellMetricInPounds = 'dumbellMetricInPounds';

  // final _oneRepMaxDeadliftItem = BehaviorSubject<OneRepMaxItem>();
  // final _oneRepMaxBenchItem = BehaviorSubject<OneRepMaxItem>();
  // final _oneRepMaxShoulderPressItem = BehaviorSubject<OneRepMaxItem>();
  // final _oneRepMaxBackSquatItem = BehaviorSubject<OneRepMaxItem>();
  // final _oneRepMaxFrontSquatItem = BehaviorSubject<OneRepMaxItem>();

  // final _persistentOneRepMaxItems = [
  //   OneRepMaxItem(name: "Deadlift", oneRepMax: 0),
  //   OneRepMaxItem(name: "Bench", oneRepMax: 0),
  //   OneRepMaxItem(name: "Shoulder Press", oneRepMax: 0),
  //   OneRepMaxItem(name: "Back Squat", oneRepMax: 0),
  //   OneRepMaxItem(name: "Front Squat", oneRepMax: 0)
  // ];

  ///
  /// One rep max saved to device.
  /// Used when choosing workouts from Settings page (i.e. bypass Firebase).
  ///
  // final OneRepMaxModel _oneRepMaxList = OneRepMaxModel(
  //     deadlift: 0, bench: 0, shoulderPress: 0, backSquat: 0, frontSquat: 0);

  // final OneRepMaxModel _oneRepMaxList = OneRepMaxModel(
  //     deadlift: {"Deadlift", 0},
  //     bench: {"Deadlift", 0},
  //     shoulderPress: {"Deadlift", 0},
  //     backSquat: {"Deadlift", 0},
  //     frontSquat: {"Deadlift", 0});

  ///
  /// Stream Getters - e.g. "stream: bloc.primaryColor" - listening to stream inside widget tree
  ///
  Stream<Brightness> get brightness => _brightness.stream;
  Stream<ColorModel> get primaryColor => _primaryColor.stream;
  // // Stream<OneRepMaxModel> get oneRepMaxes => _oneRepMaxes.stream;
  // Stream<OneRepMaxItem> get oneRepMaxDeadliftItem =>
  //     _oneRepMaxDeadliftItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxBenchItem => _oneRepMaxBenchItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxShoulderPressItem =>
  //     _oneRepMaxShoulderPressItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxBackSquatItem =>
  //     _oneRepMaxBackSquatItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxFrontSquatItem =>
  //     _oneRepMaxFrontSquatItem.stream;

  // Setters - Set
  Function(Brightness) get changeBrightness => _brightness.sink.add;
  Function(ColorModel) get changePrimaryColor => _primaryColor.sink.add;
  // // Function(OneRepMaxModel) get changeOneRepMaxes => _oneRepMaxes.sink.add;
  // Function(OneRepMaxItem) get changeOneRepMaxDeadliftItem =>
  //     _oneRepMaxDeadliftItem.sink.add;
  // Function(OneRepMaxItem) get changeOneRepMaxBenchItem =>
  //     _oneRepMaxBenchItem.sink.add;
  // Function(OneRepMaxItem) get changeOneRepMaxShoulderPressItem =>
  //     _oneRepMaxShoulderPressItem.sink.add;
  // Function(OneRepMaxItem) get changeOneRepMaxBackSquatItem =>
  //     _oneRepMaxBackSquatItem.sink.add;
  // Function(OneRepMaxItem) get changeOneRepMaxFrontSquatItem =>
  //     _oneRepMaxFrontSquatItem.sink.add;

  Stream<int> get ironMasterDumbbellSet => _ironMasterDumbbellSetItem.stream;
  Stream<double> get weighed5lbPlate => _weighed5lbPlateItem.stream;
  Stream<double> get desiredWeighed => _desiredWeightItem.stream;
  Stream<bool> get dumbbellMetricInPoundsStreamed =>
      _dumbbellMetricInPoundsItem.stream;
  // // Stream<OneRepMaxModel> get oneRepMaxes => _oneRepMaxes.stream;
  // Stream<OneRepMaxItem> get oneRepMaxDeadliftItem =>
  //     _oneRepMaxDeadliftItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxBenchItem => _oneRepMaxBenchItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxShoulderPressItem =>
  //     _oneRepMaxShoulderPressItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxBackSquatItem =>
  //     _oneRepMaxBackSquatItem.stream;
  // Stream<OneRepMaxItem> get oneRepMaxFrontSquatItem =>
  //     _oneRepMaxFrontSquatItem.stream;

  // Stream Setters - Widgets updating this data steam via sink.add,
  // adding data to sink updates data in shared preference on device.
  Function(int) get changeIronMasterDumbbellSet =>
      _ironMasterDumbbellSetItem.sink.add;

  /// ---------------------------------------------------------------------
  /// Define getter and setter
  /// ---------------------------------------------------------------------
  int get dumbbellSetChoice => _sharedPrefs?.getInt(keyDumbbellSetChoice) ?? 0;
  set dumbbellSetChoice(int value) {
    _sharedPrefs!.setInt(keyDumbbellSetChoice, value).catchError((error) {
      // エラーハンドリング
      if (kDebugMode) {
        print(
            "Something went wrong in set dumbbellSetChoice(): ${error.message}");
      }
      return false;
    });
  }

  // Stream Setters - Widgets updating this data steam via sink.add,
  // adding data to sink updates data in shared preference on device.
  Function(double) get changeWeighed5lbPlate => _weighed5lbPlateItem.sink.add;

  /// ---------------------------------------------------------------------
  /// Define getter and setter
  /// ---------------------------------------------------------------------
  double get weighed5LbPlate =>
      _sharedPrefs!.getDouble(keyWeighed5lbPlate) ?? 5.0;
  set weighed5LbPlate(double value) {
    _sharedPrefs!.setDouble(keyWeighed5lbPlate, value).catchError((error) {
      // エラーハンドリング
      if (kDebugMode) {
        print(
            "Something went wrong in set weighed5LbPlate(): ${error.message}");
      }

      return false;
    });
  }

  // Stream Setters - Widgets updating this data steam via sink.add,
  // adding data to sink updates data in shared preference on device.
  Function(double) get changeDesiredWeight => _desiredWeightItem.sink.add;

  /// ---------------------------------------------------------------------
  /// Define getter and setter
  /// ---------------------------------------------------------------------
  double get desiredWeight => _sharedPrefs!.getDouble(keyDesiredWeight) ?? 5.0;
  set desiredWeight(double value) {
    _sharedPrefs!.setDouble(keyDesiredWeight, value).catchError((error) {
      // エラーハンドリング
      if (kDebugMode) {
        print("Something went wrong in set desiredWeight(): ${error.message}");
      }

      return false;
    });
  }

  // keyDumbbellMetricInPounds
  // Stream Setters - Widgets updating this data steam via sink.add,
  // adding data to sink updates data in shared preference on device.
  Function(bool) get changeDumbbellMetricInPounds =>
      _dumbbellMetricInPoundsItem.sink.add;

  /// ---------------------------------------------------------------------
  /// Define getter and setter
  /// ---------------------------------------------------------------------
  ///
  bool get dumbbellMetricInPounds =>
      _sharedPrefs!.getBool(keyDumbbellMetricInPounds) ?? false;
  set dumbbellMetricInPounds(bool value) {
    _sharedPrefs!.setBool(keyDumbbellMetricInPounds, value).catchError((error) {
      // エラーハンドリング
      if (kDebugMode) {
        print(
            "Something went wrong in set dumbbellMetricInPounds(): ${error.message}");
      }
      return false;
    });
  }

  ///
  /// Helper  function
  ///
  indexToPrimaryColor(double index) {
    return _colors.firstWhere((x) => x.index == index);
  }

  ///
  /// Helper  function
  ///
  // OneRepMaxItem nameToOneRepMaxItem(String name) {
  //   int itemIndex = 0;
  //   for (String itemName in oneRepMaxNames) {
  //     if (name == itemName) {
  //       break;
  //     }
  //     itemIndex++;
  //   }
  //   switch (itemIndex) {
  //     case 0:
  //       return oneRepMaxDeadliftItem;

  //       break;
  //     default:
  //   }

  // }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_brightness.value == Brightness.light) {
      await prefs.setBool('dark', false);
    } else {
      await prefs.setBool('dark', true);
    }

    await prefs.setDouble('colorIndex', _primaryColor.value.index);

    await prefs.setInt(keyDumbbellSetChoice, _ironMasterDumbbellSetItem.value);
    // Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //     .dumbbellSet);

    await prefs.setDouble(keyWeighed5lbPlate, _weighed5lbPlateItem.value);
    await prefs.setDouble(keyDesiredWeight, _desiredWeightItem.value);

    await prefs.setBool(
        keyDumbbellMetricInPounds, _dumbbellMetricInPoundsItem.value);

    // Provider.of<WeightRackBlocNotifier>(context,
    //                                   listen: false)
    //                               .isDumbbellSingleView

    // await prefs.setDouble('keyWeighed5lbPlate', _primaryColor.value.index);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? darkMode = prefs.get('dark') as bool?;
    double? colorIndex = prefs.get('colorIndex') as double?;

    if (darkMode != null) {
      (darkMode == false)
          ? changeBrightness(Brightness.light)
          : changeBrightness(Brightness.dark);
    } else {
      changeBrightness(Brightness.light);
    }

    if (colorIndex != null) {
      changePrimaryColor(indexToPrimaryColor(colorIndex));
    } else {
      changePrimaryColor(
          ColorModel(color: Colors.blue, index: 0.0, name: 'Blue'));
    }

    int? dumbellSetChoice = prefs.get(keyDumbbellSetChoice) as int?;
    if (dumbellSetChoice != null) {
      changeIronMasterDumbbellSet(dumbellSetChoice);
    } else {
      changeIronMasterDumbbellSet(1); // Default to 1 for 75lb Dumbbell Set
    }

    double? weighed5lbPlate = prefs.get(keyWeighed5lbPlate) as double?;
    if (weighed5lbPlate != null) {
      changeWeighed5lbPlate(weighed5lbPlate);
    } else {
      changeWeighed5lbPlate(5.0); // Default to 1 for 75lb Dumbbell Set
    }

    double? desiredWeight = prefs.get(keyDesiredWeight) as double?;
    if (desiredWeight != null) {
      changeDesiredWeight(desiredWeight);
    } else {
      changeDesiredWeight(5.0); // Default weight
    }

    bool? dumbellMetricInPounds = prefs.get(keyDumbbellMetricInPounds) as bool?;
    if (dumbellMetricInPounds != null) {
      changeDumbbellMetricInPounds(dumbellMetricInPounds);
    } else {
      changeDumbbellMetricInPounds(true); // Default
    }

    // ///
    // /// load 1RM preferences
    // ///
    // double deadlift1RM = prefs.getDouble(keyDeadlift1RM);
    // if (deadlift1RM != null) {
    //   // Special Information:
    //   //
    //   //    The 1RM values are ALWAYS saved as LB on the device.
    //   //
    //   changeDeadlift1RM(deadlift1RM);
    // } else {
    //   changeDeadlift1RM(0);
    // }

    // changeOneRepMaxDeadliftItem(prefs.get(OneRepMaxItem(oneRepMax: ))

    // ///
    // /// load 1RM preferences
    // ///
    // OneRepMaxItem deadliftItem = prefs.get('changeOneRepMaxDeadliftItem');
    // if (deadliftItem != null) {
    //   changeOneRepMaxDeadliftItem(deadliftItem);
    // } else {
    //   changeOneRepMaxDeadliftItem(
    //       OneRepMaxItem(name: "Deadlift", oneRepMax: 0));
    // }

    // OneRepMaxItem benchItem = prefs.get('changeOneRepMaxBenchItem');
    // if (benchItem != null) {
    //   changeOneRepMaxBenchItem(benchItem);
    // } else {
    //   changeOneRepMaxBenchItem(OneRepMaxItem(name: "Bench", oneRepMax: 0));
    // }

    // OneRepMaxItem shoulderPressItem =
    //     prefs.get('changeOneRepMaxShoulderPressItem');
    // if (shoulderPressItem != null) {
    //   changeOneRepMaxShoulderPressItem(shoulderPressItem);
    // } else {
    //   changeOneRepMaxShoulderPressItem(
    //       OneRepMaxItem(name: "Shoulder Press", oneRepMax: 0));
    // }

    // OneRepMaxItem backSquatItem = prefs.get('changeOneRepMaxBackSquatItem');
    // if (backSquatItem != null) {
    //   changeOneRepMaxBackSquatItem(backSquatItem);
    // } else {
    //   changeOneRepMaxBackSquatItem(
    //       OneRepMaxItem(name: "Back Squat", oneRepMax: 0));
    // }

    // OneRepMaxItem frontSquatItem = prefs.get('changeOneRepMaxFrontSquatItem');
    // if (frontSquatItem != null) {
    //   changeOneRepMaxFrontSquatItem(frontSquatItem);
    // } else {
    //   changeOneRepMaxFrontSquatItem(
    //       OneRepMaxItem(name: "Front Squat", oneRepMax: 0));
    // }
  }

  // saveOneRepMaxPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (_brightness.value == Brightness.light) {
  //     await prefs.setBool('dark', false);
  //   } else {
  //     await prefs.setBool('dark', true);
  //   }
  // }

  // ///
  // /// One rep max
  // ///
  // loadOneRepMaxPreferences() async {}

  // /// Get on erep maxes.
  // Future<int> getDeadlift1RMFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('deadlift1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // Future<int> getBench1RMFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('bench1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // Future<int> getShoulderPress1RMFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('shoulderPress1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // Future<int> getBackSquat1RMFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('backSquat1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // getBackSquat1RMFromSharedPrefNonFuture() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('backSquat1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // Future<int> getFrontSquat1RMFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('frontSquat1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // getFrontSquat1RMFromSharedPrefNonFuture() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('frontSquat1RM');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // Future<int> getDefaultBackSquatBarbellFromSharedPref() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getInt('defaultBackSquatBarbell');
  //   if (value == null) {
  //     return 0;
  //   }
  //   return value;
  // }

  // /// Set one rep maxes.
  // Future<void> setDeadlift1RMFromSharedPref(int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('deadlift1RM', newOneRepMax);
  // }

  // Future<void> setBench1RMFromSharedPref(int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('bench1RM', newOneRepMax);
  // }

  // Future<void> setShoulderPress1RMFromSharedPref(int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('shoulderPress1RM', newOneRepMax);
  // }

  // Future<void> setBackSquat1RMFromSharedPref(int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('backSquat1RM', newOneRepMax);
  // }

  // Future<void> setFrontSquat1RMFromSharedPref(int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('frontSquat1RM', newOneRepMax);
  // }

  // Future<void> setDefaultBackSquatBarbellFromSharedPref(
  //     int newOneRepMax) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('defaultBackSquatBarbell', newOneRepMax);
  // }

  dispose() {
    _primaryColor.close();
    _brightness.close();

    _ironMasterDumbbellSetItem.close();
    _weighed5lbPlateItem.close();
    _desiredWeightItem.close();
    _dumbbellMetricInPoundsItem.close();
  }
}
