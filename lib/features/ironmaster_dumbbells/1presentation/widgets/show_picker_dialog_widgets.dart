// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/weightplate_model.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/picker/new_number_picker.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/picker/new_number_picker.dart';
// import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/calculate_weight_onbarbell.dart';

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gShowBarbellPickerArray
// ///
// ///   Special Information:  This class is called by the TabbedWorkoutAccessoryWendlerWidget
// ///                         and TabbedWorkoutAccessoryHatchWidget classes in the
// ///                         tab_widget.dart file.
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// // gShowBarbellPickerArray(BuildContext context, int queryEnteredWeight,
// //     int oneRepMax, double percent, AnimatedBarbell animatedBarbell) {
// //   final mediaQuery = MediaQuery.of(context);

// //   double textScaleFactor = 0.05;

// //   if (Platform.isIOS && giSiPadDevice == true) {
// //     textScaleFactor =
// //         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
// //   }

// //   var barbellPickerData = gGetCurrentBarbellList(context);

// //   return NewBarbellPicker(
// //       title: new Text("Select Barbell",
// //           style: TextStyle(
// //               color: Colors
// //                   .orangeAccent, //Theme.of(context).accentColor, //Colors.white,
// //               fontSize: mediaQuery.size.width * textScaleFactor,
// //               fontWeight: FontWeight.bold)),
// //       containerColor: Colors.black26,
// //       // containerColor: (Theme.of(context).brightness == Brightness.light)
// //       //     ? Colors.black26
// //       //     : Colors.black26,
// //       textStyle: TextStyle(
// //           color: Colors.orangeAccent,
// //           // color: (Theme.of(context).brightness == Brightness.light)
// //           //     ? Colors.black54
// //           //     : Colors.orangeAccent,
// //           fontSize: mediaQuery.size.width * textScaleFactor,
// //           fontWeight: FontWeight.bold),
// //       columnPadding: EdgeInsets.all(4),
// //       itemExtent: 48,
// //       backgroundColor: Colors.black26,
// //       // backgroundColor: (Theme.of(context).brightness == Brightness.light)
// //       //     ? Colors.white
// //       //     : Colors.black26,
// //       adapter: NewBarbellPickerDataAdapter<String>(
// //           pickerdata: new JsonDecoder().convert(barbellPickerData),
// //           // data: barbellPickerItemList,
// //           isArray: true),
// //       hideHeader: true,
// //       looping: false,
// //       onConfirm: (NewBarbellPicker picker, List value) {
// //         ///
// //         /// Add Change Barbell logic here.
// //         ///
// //         // print(value.toString());
// //         // print(picker.getSelectedValues());
// //         //
// //         // Update barbell Provider/Notifier
// //         //
// //         Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
// //                 .barbellInUse =
// //             getCurrentBarbellTypeEnumFromPickerList(
// //                 context, picker.getSelectedValues()[0]);

// //         ///
// //         /// The desired weight is determined by the context of the
// //         /// workout, for Wendler and Hatch workout context, use the
// //         /// 1RM calculation.  For LoadBarbellView (e.g. from Main Menu)
// //         /// context, use the _queryEnteredWeight.
// //         ///
// //         int desiredWeight = 0;
// //         if (Provider.of<MenuNotifier>(context, listen: false)
// //                 .statePreviousPage ==
// //             MainMeuWorkoutsEnum.HOME) {
// //           desiredWeight = queryEnteredWeight;
// //         } else {
// //           // Calculate the weight to load on the barbell.
// //           desiredWeight = (oneRepMax * percent).toInt();
// //         }

// //         // Immediately trigger the event
// //         BlocProvider.of<WeightrackBloc>(context)
// //           ..add(WeightrackChangeBarbell(
// //               context, desiredWeight, oneRepMax, percent, animatedBarbell));
// //       }).showDialog(context);
// // }

// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // ///
// // ///   Function:  gShowAddNewBarbellPickerArray
// // ///
// // ///   Special Information:  This class is used by the AddNewBarbellPage class in
// // ///                         add_new_barbell_page.dart
// // ///
// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // NewBarbellPicker gShowAddNewBarbellPickerArray(BuildContext context,
// //     {Function onConfirm, bool hideHeader = true}) {
// //   final mediaQuery = MediaQuery.of(context);

// //   double textScaleFactor = 0.05;

// //   if (Platform.isIOS && giSiPadDevice == true) {
// //     textScaleFactor =
// //         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
// //   }

// //   var barbellPickerData = gGetCurrentBarbellList(context);

// //   return NewBarbellPicker(
// //       title: new Text("Select Barbell",
// //           style: TextStyle(
// //               color: Colors.orangeAccent,
// //               fontSize: mediaQuery.size.width * textScaleFactor,
// //               fontWeight: FontWeight.bold)),
// //       containerColor: Colors.black26,
// //       textStyle: TextStyle(
// //           color: Colors.orangeAccent,
// //           fontSize: mediaQuery.size.width * textScaleFactor,
// //           fontWeight: FontWeight.bold),
// //       columnPadding: EdgeInsets.all(4),
// //       itemExtent: 44,
// //       backgroundColor: Colors.black26,
// //       adapter: NewBarbellPickerDataAdapter<String>(
// //           pickerdata: new JsonDecoder().convert(barbellPickerData),
// //           // data: barbellPickerItemList,
// //           isArray: true),
// //       hideHeader: hideHeader,
// //       looping: false,
// //       onConfirm: (NewBarbellPicker picker, List value) {
// //         ///
// //         /// No logic here, only display the barbells, the
// //         /// Add or Delete button changes the content of this picker.
// //         ///
// //         // print(value.toString());
// //         // print(picker.getSelectedValues());
// //         if (onConfirm != null) {
// //           onConfirm(picker);
// //         }
// //       });
// // }

// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // ///
// // ///   Function:  gShowChangeBarbellPickerArray
// // ///
// // ///   Special Information:  This class is used by the TabWidget class in
// // ///                         loadbarbellhome_view.dart
// // ///
// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // NewBarbellPicker gShowChangeBarbellPickerArray(BuildContext context,
// //     {Function onConfirm, bool hideHeader = true}) {
// //   final mediaQuery = MediaQuery.of(context);
// //   var barbellPickerData = gGetCurrentBarbellList(context);

// //   double textScaleFactor = 0.05;

// //   if (Platform.isIOS && giSiPadDevice == true) {
// //     textScaleFactor =
// //         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
// //   }

// //   return NewBarbellPicker(
// //       title: new Text("Select Barbell",
// //           style: TextStyle(
// //               color: Colors.orangeAccent,
// //               fontSize: mediaQuery.size.width * textScaleFactor,
// //               fontWeight: FontWeight.bold)),
// //       containerColor: Colors.black26,
// //       textStyle: TextStyle(
// //           color: Colors.orangeAccent,
// //           fontSize: mediaQuery.size.width * textScaleFactor,
// //           fontWeight: FontWeight.bold),
// //       columnPadding: EdgeInsets.all(4),
// //       itemExtent: 44,
// //       backgroundColor: Colors.black26,
// //       // backgroundColor: (Theme.of(context).brightness == Brightness.light)
// //       //     ? Colors.white
// //       //     : Colors.black26,
// //       adapter: NewBarbellPickerDataAdapter<String>(
// //           pickerdata: new JsonDecoder().convert(barbellPickerData),
// //           // data: barbellPickerItemList,
// //           isArray: true),
// //       hideHeader: hideHeader,
// //       looping: false,
// //       onConfirm: (NewBarbellPicker picker, List value) {
// //         ///
// //         /// Add Change Barbell logic here.
// //         ///
// //         // print(value.toString());
// //         // print(picker.getSelectedValues());
// //         if (onConfirm != null) {
// //           onConfirm(picker);
// //         }
// //       });
// // }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gShowSetDefaultBarbellPickerArray
// ///
// ///   Special Information:  This class is used in
// ///                         set_default_barbell_page.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// // NewBarbellPicker gShowSetDefaultBarbellPickerArray(BuildContext context,
// //     {Function onConfirm,
// //     bool hideHeader = true,
// //     ExerciseMovementEnum exerciseMovement}) {
// //   final mediaQuery = MediaQuery.of(context);
// //   var barbellPickerData = gGetCurrentBarbellList(context);

// //   double textScaleFactor = 0.05;

// //   if (Platform.isIOS && giSiPadDevice == true) {
// //     textScaleFactor =
// //         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
// //   }

// //   return NewBarbellPicker(
// //       title: new Text("Select Barbell",
// //           style: TextStyle(
// //               color: Colors.orangeAccent,
// //               fontSize: mediaQuery.size.width * textScaleFactor,
// //               fontWeight: FontWeight.bold)),
// //       containerColor: Colors.black26,
// //       textStyle: TextStyle(
// //           color: Colors.orangeAccent,
// //           fontSize: mediaQuery.size.width * textScaleFactor,
// //           fontWeight: FontWeight.bold),
// //       columnPadding: EdgeInsets.all(4),
// //       itemExtent: 48,
// //       backgroundColor: Colors.black26,
// //       // backgroundColor: (Theme.of(context).brightness == Brightness.light)
// //       //     ? Colors.white
// //       //     : Colors.black26,
// //       adapter: NewBarbellPickerDataAdapter<String>(
// //           pickerdata: new JsonDecoder().convert(barbellPickerData),
// //           // data: barbellPickerItemList,
// //           isArray: true),
// //       hideHeader: hideHeader,
// //       looping: false,
// //       onConfirm: (NewBarbellPicker picker, List value) {
// //         ///
// //         /// Add Change Barbell logic here.
// //         ///
// //         // print(value.toString());
// //         // print(picker.getSelectedValues());
// //         if (onConfirm != null) {
// //           onConfirm(picker, exerciseMovement);
// //         }
// //       });
// // }

// // const gNumberPickerData = '''
// // [
// //     [
// //         1,
// //         2,
// //         3,
// //         4
// //     ],
// //     [
// //         11,
// //         22,
// //         33,
// //         44
// //     ],
// //     [
// //         "aaa",
// //         "bbb",
// //         "ccc"
// //     ]
// // ]
// //     ''';

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gShowNumberCountPickerArray
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// // NewNumberPicker gShowNumberCountPickerArray(
// //     BuildContext context, Widget titleWidget,
// //     {Function onConfirm,
// //     bool hideHeader = true,
// //     String title = "",
// //     int initialWholeValue = 0,
// //     int initialFactionValue = 0}) {
// //   final mediaQuery = MediaQuery.of(context);

// //   double textScaleFactor = 0.05;

// //   if (Platform.isIOS && giSiPadDevice == true) {
// //     textScaleFactor =
// //         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
// //   }

// //   const numberDigitPickerData = '''
// // [
// //     [
// //         0,1,2,3,4,5,6,7,8,9,
// //         10,11,12,13,14,15,16,17,18,19,
// //         20,21,22,23,24,25,26,27,28,29,
// //         30,31,32,33,34,35,36,37,38,39,
// //         40,41,42,43,44,45,46,47,48,49,
// //         50,51,52,53,54,55,56,57,58,59,
// //         60,61,62,63,64,65,66,67,68,69,
// //         70,71,72,73,74,75,76,77,78,79,
// //         80,81,82,83,84,85,86,87,88,89,
// //         90,91,92,93,94,95,96,97,98,99,
// //         100
// //     ]
// // ]
// //     ''';

// //   return NewNumberPicker(
// //       title: (titleWidget == null)
// //           ? new Text(title,
// //               style: TextStyle(
// //                   color: Colors.orangeAccent,
// //                   fontSize: mediaQuery.size.width * textScaleFactor,
// //                   fontWeight: FontWeight.bold))
// //           : titleWidget,
// //       containerColor: Colors.black26,
// //       textStyle: TextStyle(
// //           color: Colors.orangeAccent,
// //           fontSize: mediaQuery.size.width * textScaleFactor,
// //           fontWeight: FontWeight.bold),
// //       columnPadding: EdgeInsets.all(4),
// //       itemExtent: 54,
// //       backgroundColor: Colors.black26,
// //       initialWholeValue: initialWholeValue,
// //       initialFactionValue: initialFactionValue,
// //       adapter: NewNumberPickerDataAdapter<String>(
// //           pickerdata: new JsonDecoder().convert(numberDigitPickerData),
// //           isArray: true),
// //       hideHeader: hideHeader,
// //       looping: false,
// //       onConfirm: (NewNumberPicker picker, List value) {
// //         ///
// //         /// Add Change plate count logic here.
// //         ///
// //         // print(value.toString());
// //         // print(picker.getSelectedValues());
// //         onConfirm(picker);
// //       });
// // }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gShowChangePlateCountPickerArray
// ///
// ///   Special Information:  This class is used in weightrack_view.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// NewNumberPicker gShowChangePlateCountPickerArray(BuildContext context,
//     {Function onConfirm,
//     bool hideHeader = true,
//     String title = "",
//     bool doubleDigit = false,
//     // bool evenNumbersOnly = false,
//     int initialWholeValue = 0,
//     int initialFactionValue = 0}) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

//   const numberPickerData = '''
// [
//     [
//         0,
//         2,
//         4,
//         6,
//         8,10,12,14,16,18,20,22,24,26,28,30
//     ]
// ]
//     ''';

//   const numberDoubleDigitPickerData = '''
// [
//     [
//         0,1,2,3,4,5,6,7,8,9,
//         10,11,12,13,14,15,16,17,18,19,
//         20,21,22,23,24,25,26,27,28,29,
//         30,31,32,33,34,35,36,37,38,39,
//         40,41,42,43,44,45,46,47,48,49,
//         50,51,52,53,54,55,56,57,58,59,
//         60,61,62,63,64,65,66,67,68,69,
//         70,71,72,73,74,75,76,77,78,79,
//         80,81,82,83,84,85,86,87,88,89,
//         90,91,92,93,94,95,96,97,98,99,
//         100
//     ],
//     ["."],
//     [
//         0,
//         1,
//         2,
//         3,4,5,6,7,8,9
//     ]
// ]
//     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           pickerdata: new JsonDecoder().convert((doubleDigit == true)
//               ? numberDoubleDigitPickerData
//               : numberPickerData),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // ///
// // ///   Function:  gShowTrainingMaxPickerArray
// // ///
// // ///   Special Information:  This class is used in wendler_newcycle_view.dart
// // ///
// // /////////////////////////////////////////////////////////////////////////////////////////////////
// // ///
// // int gGetTrainingMaxIndexFromPicker(int trainingMax) {
// //   List<int> tmList = [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100];
// //   for (int index = 0; index < tmList.length; index++) {
// //     if (tmList[index] == trainingMax) {
// //       return index;
// //     }
// //   }

// //   return 0;
// // }

// NewNumberPicker gShowIronMaster45LbSetPickerArray(
//   BuildContext context,
//   // int queryEnteredWeight,
//   // int oneRepMax,
//   // double percent,
//   // AnimatedBarbell animatedBarbell,
//   {
//   Function onConfirm,
//   bool hideHeader = true,
//   String title = "",
//   int initialWholeValue = 0,
//   int initialFactionValue = 0,
//   double userSpecified5lbPlateWeight: 5.0,
// }) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

//   const numberPickerData = '''
// [
//     [
//         5,
//         10,
//         15,
//         20,
//         25,
//         30,
//         35,
//         40,
//         45
//     ]
// ]
//     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           // pickerdata: new JsonDecoder().convert(numberPickerData),
//           pickerdata: new JsonDecoder()
//               .convert(gGetCurrent45lbWeightList(userSpecified5lbPlateWeight)),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// ///
// NewNumberPicker gShowIronMaster75LbSetPickerArray(
//   BuildContext context,
//   // int queryEnteredWeight,
//   // int oneRepMax,
//   // double percent,
//   // AnimatedBarbell animatedBarbell,
//   {
//   Function onConfirm,
//   bool hideHeader = true,
//   String title = "",
//   int initialWholeValue = 0,
//   int initialFactionValue = 0,
//   double userSpecified5lbPlateWeight: 5.0,
// }) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

// //   const numberPickerData = '''
// // [
// //     [
// //         5,
// //         10,
// //         15,
// //         20,
// //         25,
// //         30,
// //         35,
// //         40,
// //         45,
// //         50,
// //         55,
// //         60,
// //         65,
// //         70,
// //         75
// //     ]
// // ]
// //     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           pickerdata: new JsonDecoder().convert(gGetCurrent75lbWeightList(
//               userSpecified5lbPlateWeight)), //numberPickerData),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// NewNumberPicker gShowIronMaster120LbSetPickerArray(
//   BuildContext context,
//   // int queryEnteredWeight,
//   // int oneRepMax,
//   // double percent,
//   // AnimatedBarbell animatedBarbell,
//   {
//   Function onConfirm,
//   bool hideHeader = true,
//   String title = "",
//   int initialWholeValue = 0,
//   int initialFactionValue = 0,
//   double userSpecified5lbPlateWeight: 5.0,
// }) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

// //   const numberPickerData = '''
// // [
// //     [
// //         5,
// //         10,
// //         15,
// //         20,
// //         25,
// //         30,
// //         35,
// //         40,
// //         45,
// //         50,
// //         55,
// //         60,
// //         65,
// //         70,
// //         75,
// //         80,
// //     85,
// //     90,
// //     95,
// //     100,
// //     105,
// //     110,
// //     115,
// //     120
// //     ]
// // ]
// //     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           // pickerdata: new JsonDecoder().convert(numberPickerData),
//           pickerdata: new JsonDecoder()
//               .convert(gGetCurrent120lbWeightList(userSpecified5lbPlateWeight)),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// NewNumberPicker gShowIronMaster165LbSetPickerArray(
//   BuildContext context,
// // String weightPlatesjSonList,
//   // int queryEnteredWeight,
//   // int oneRepMax,
//   // double percent,
//   // AnimatedBarbell animatedBarbell,
//   {
//   Function onConfirm,
//   bool hideHeader = true,
//   String title = "",
//   int initialWholeValue = 0,
//   int initialFactionValue = 0,
//   double userSpecified5lbPlateWeight: 5.0,
// }) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

// //   const numberPickerData = '''
// // [
// //     [
// //         5,
// //         10,
// //         15,
// //         20,
// //         25,
// //         30,
// //         35,
// //         40,
// //         45,
// //         50,
// //         55,
// //         60,
// //         65,
// //         70,
// //         75,
// //         80,
// //     85,
// //     90,
// //     95,
// //     100,
// //     105,
// //     110,
// //     115,
// //     120, 125, 130, 135, 140, 145, 150, 155, 160, 165
// //     ]
// // ]
// //     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           pickerdata: new JsonDecoder().convert(
//               gGetCurrent165lbWeightList(context, userSpecified5lbPlateWeight)),
//           // pickerdata: new JsonDecoder().convert(numberPickerData),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gIronMaster45LbWeightIndexFromPicker
// ///
// ///   Special Information:  This class is used in loadbarbell_view.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// int gIronMaster45LbWeightIndexFromPicker(int weight) {
//   List<int> list = [5, 10, 15, 20, 25, 30, 35, 40, 45];
//   for (int index = 0; index < list.length; index++) {
//     if (list[index] == weight) {
//       return index;
//     }
//   }

//   return 0;
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gIronMaster75LbWeightIndexFromPicker
// ///
// ///   Special Information:  This class is used in loadbarbell_view.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// int gIronMaster75LbWeightIndexFromPicker(int weight) {
//   List<int> list = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75];
//   for (int index = 0; index < list.length; index++) {
//     if (list[index] == weight) {
//       return index;
//     }
//   }

//   return 0;
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gIronMaster120LbWeightIndexFromPicker
// ///
// ///   Special Information:  This class is used in loadbarbell_view.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// // int gIronMaster120LbWeightIndexFromPicker(int weight) {
// //   List<int> list = [
// //     5,
// //     10,
// //     15,
// //     20,
// //     25,
// //     30,
// //     35,
// //     40,
// //     45,
// //     50,
// //     55,
// //     60,
// //     65,
// //     70,
// //     75,
// //     80,
// //     85,
// //     90,
// //     95,
// //     100,
// //     105,
// //     110,
// //     115,
// //     120
// //   ];
// //   for (int index = 0; index < list.length; index++) {
// //     if (list[index] == weight) {
// //       return index;
// //     }
// //   }

// //   return 0;
// // }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gIronMaster165LbWeightIndexFromPicker
// ///
// ///   Special Information:  This class is used in loadbarbell_view.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// // int gIronMaster165LbWeightIndexFromPicker(int weight) {
// //   List<int> list = [
// //     5,
// //     10,
// //     15,
// //     20,
// //     25,
// //     30,
// //     35,
// //     40,
// //     45,
// //     50,
// //     55,
// //     60,
// //     65,
// //     70,
// //     75,
// //     80,
// //     85,
// //     90,
// //     95,
// //     100,
// //     105,
// //     110,
// //     115,
// //     120,
// //     125,
// //     130,
// //     135,
// //     140,
// //     145,
// //     150,
// //     155,
// //     160,
// //     165
// //   ];
// //   for (int index = 0; index < list.length; index++) {
// //     if (list[index] == weight) {
// //       return index;
// //     }
// //   }

// //   return 0;
// // }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gGetCurrent45lbWeightList
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// String gGetCurrent45lbWeightList(double real5lbWeight) {
//   ///
//   /// Create a list of plates increasing in weight.
//   /// This is converted to jSon format
//   ///
//   List<dynamic> weightList = [5, 10, 15];
//   const int TOTAL_5LB_PLATES_PER_DUMBBELL = 3;
//   for (double i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL; ++i) {
//     double formatedWeight = 10.0 + (real5lbWeight * (2 * i));
//     // double fraction = formatedWeight - formatedWeight.truncate();
//     // if (fraction < 0.5) {
//     //   weightList.add(formatedWeight.floor().toInt());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//     //   // when using 5 instead of (2.5 * 2)
//     //   weightList.add(formatedWeight.floor().toInt() + (5));
//     // } else {
//     //   weightList.add(formatedWeight.ceil().toInt());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to "5"
//     //   // when using 5, but formats to "5.0" if using (2.5 * 2).
//     //   weightList.add(formatedWeight.ceil().toInt() + (5));
//     // }
//     weightList.add(formatedWeight.ceil()); //.toDouble());
//     weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
//   }

//   ///
//   /// Use jsonEncode() function to create the Picker Data List.
//   ///
//   return "[" + jsonEncode(weightList) + "]";
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gGetCurrent75lbWeightList
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// String gGetCurrent75lbWeightList(double real5lbWeight) {
//   ///
//   /// Create a list of plates increasing in weight.
//   /// This is converted to jSon format
//   ///
//   List<dynamic> weightList = [5, 10, 15];
//   const int TOTAL_5LB_PLATES_PER_DUMBBELL = 6;
//   for (double i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL; ++i) {
//     // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//     // double fraction = formatedWeight - formatedWeight.truncate();
//     // if (fraction < 0.5) {
//     //   weightList.add(formatedWeight.floor());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//     //   // when using 5 instead of (2.5 * 2)
//     //   weightList.add(formatedWeight.floor() + (5));
//     // } else {
//     //   weightList.add(formatedWeight.ceil().round());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to "5"
//     //   // when using 5, but formats to "5.0" if using (2.5 * 2).
//     //   weightList.add(formatedWeight.ceil().round() + (5));
//     // }

//     double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

//     weightList.add(formatedWeight.ceil()); //.toDouble());
//     weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
//   }

//   ///
//   /// Use jsonEncode() function to create the Picker Data List.
//   ///
//   return "[" + jsonEncode(weightList) + "]";
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gGetCurrent120lbWeightList
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// String gGetCurrent120lbWeightList(double real5lbWeight) {
//   ///
//   /// Create a list of plates increasing in weight.
//   /// This is converted to jSon format
//   ///
//   List<dynamic> weightList = [5, 10, 15];
//   const int TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE = 6;
//   double currentWeight = 15.0;

//   for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE; ++i) {
//     // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//     // double fraction = formatedWeight - formatedWeight.truncate();
//     // if (fraction < 0.5) {
//     //   weightList.add(formatedWeight.floor());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//     //   // when using 5 instead of (2.5 * 2)
//     //   weightList.add(formatedWeight.floor() + (5));
//     // } else {
//     //   weightList.add(formatedWeight.ceil().round());
//     //   // 5lb is the 2.5lb plates x 2, dart formats fractions to "5"
//     //   // when using 5, but formats to "5.0" if using (2.5 * 2).
//     //   weightList.add(formatedWeight.ceil().round() + (5));
//     // }
//     // currentWeight += (real5lbWeight * 2);
//     double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

//     weightList.add(formatedWeight.ceil()); //.toDouble());
//     weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
//     currentWeight += (real5lbWeight * 2);
//     currentWeight = currentWeight.ceilToDouble();
//   }

//   ///
//   /// 120lb Set comes with two 22.5 plates per dunbbell..
//   ///
//   double maxWeight = 15.0 +
//       (2 * 22.5) +
//       (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));
//   while (currentWeight < maxWeight) {
//     currentWeight += real5lbWeight;

//     weightList.add(currentWeight.toInt()); //.round());
//     // weightList.add(currentWeight.ceil().round());
//   }

//   ///
//   /// Use jsonEncode() function to create the Picker Data List.
//   ///
//   return "[" + jsonEncode(weightList) + "]";
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gGetCurrent165lbWeightList
// ///
// /// When 22.5lb checkbox plate NOT selected:
// /// [5, 10, 15, 20, 25, 29, 34, 38, 43, 47, 52, 56, 61, 66, 71, 80, 85, 89, 94, 98, 103, 108, 112, 117, 121, 126, 131, 135, 140, 144, 149, 154, 158, 163]
// ///
// /// When 22.5lb checkbox plate selected:
// /// [5, 10, 15, 20, 25, 29, 34, 39, 43, 48, 52, 57, 62, 66, 71, 93, 116, 138, 161]
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// String gGetCurrent165lbWeightList(BuildContext context, double real5lbWeight) {
//   ///
//   /// Create a list of plates increasing in weight.
//   /// This is converted to jSon format
//   ///
//   List<dynamic> weightList = [5, 10, 15];
//   const int TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE = 6;
//   //show22lbPlatesCheckboxAndGraphics = true;
//   if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
//           .useHeavy22lbPlatesBottomRight ==
//       false) {
//     double currentWeight = 15.0;

//     for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE; ++i) {
//       // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//       // double fraction = formatedWeight - formatedWeight.truncate();
//       // if (fraction < 0.5) {
//       //   // weightList.add(formatedWeight.floor());
//       //   weightList.add(formatedWeight.floor().toInt());
//       //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//       //   // when using 5 instead of (2.5 * 2)
//       //   weightList.add(formatedWeight.floor().toInt() + (5));
//       // } else {
//       //   weightList.add(formatedWeight.ceil().toInt());
//       //   // when using 5, but formats to "5.0" if using (2.5 * 2).
//       //   weightList.add(formatedWeight.ceil().toInt() + (5));
//       // }
//       // currentWeight += (real5lbWeight * 2);
//       double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

//       weightList.add(formatedWeight.ceil()); //.toDouble());
//       weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
//       currentWeight += (real5lbWeight * 2);
//       currentWeight = currentWeight.ceilToDouble();
//     }

//     ///
//     /// 165lb Set comes with four 22.5 plates per dunbbell..
//     ///
//     double maxWeight = 15.0 +
//         (4 * 22.5) +
//         (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));
//     while (currentWeight < maxWeight) {
//       // if (currentWeight >= 55.0 && currentWeight <= 75.0) {
//       //   //show22lbPlatesCheckboxAndGraphics = true;
//       //   if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
//       //           .useHeavy22lbPlatesBottomRight ==
//       //       true) {}
//       // }

//       currentWeight += real5lbWeight;
//       // currentWeight = currentWeight.ceilToDouble();

//       weightList.add(currentWeight.ceil());
//     }
//     print("22.5lb NOT CHECKED weightList[] = $weightList");
//   } else {
//     ///
//     /// To get list of ALL possible weight combinations,
//     /// when 22.5lb checkbox is checked, then iterate:
//     /// 1. With all 5lb plates. - Until < 55lb
//     /// 2. With 22.5lb plate pair + 5lb plates
//     /// 3. With 2 x 22.5lb plate pair + 5lb plates
//     ///

//     ///
//     /// 165lb Set comes with four 22.5 plates per dunbbell..
//     ///
//     double currentWeight = 15.0;

//     double maxWeight = currentWeight +
//         (4 * 22.5) +
//         (real5lbWeight * (TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2));

//     // Add 4.5lb / 5lb Plates
//     int add5lbPlateCount = 0;
//     while (add5lbPlateCount < TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE * 2) {
//       // while (currentWeight < maxWeight) {
//       // if (currentWeight >= 55.0 && currentWeight <= 75.0) {
//       //   //show22lbPlatesCheckboxAndGraphics = true;
//       //   if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
//       //           .useHeavy22lbPlatesBottomRight ==
//       //       true) {}
//       // }

//       // if (currentWeight > 75.0) {
//       //   currentWeight +=
//       // }
//       currentWeight += real5lbWeight;
//       // currentWeight = currentWeight.ceilToDouble();
//       add5lbPlateCount++;

//       weightList.add(currentWeight.ceil());
//     }

//     // Add 22.5lb plates
//     int add22p5PlateCount = 0;
//     while (add22p5PlateCount < 4) {
//       currentWeight += 22.5;
//       add22p5PlateCount++;
//       weightList.add(currentWeight.ceil());
//     }

//     print("22.5lb CHECKED weightList[] = $weightList");

//     // for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL_SIDE; ++i) {
//     //   // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//     //   // double fraction = formatedWeight - formatedWeight.truncate();
//     //   // if (fraction < 0.5) {
//     //   //   // weightList.add(formatedWeight.floor());
//     //   //   weightList.add(formatedWeight.floor().toInt());
//     //   //   // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//     //   //   // when using 5 instead of (2.5 * 2)
//     //   //   weightList.add(formatedWeight.floor().toInt() + (5));
//     //   // } else {
//     //   //   weightList.add(formatedWeight.ceil().toInt());
//     //   //   // when using 5, but formats to "5.0" if using (2.5 * 2).
//     //   //   weightList.add(formatedWeight.ceil().toInt() + (5));
//     //   // }
//     //   // currentWeight += (real5lbWeight * 2);
//     //   double formatedWeight = 10.0 + (real5lbWeight * (2 * i));

//     //   weightList.add(formatedWeight.ceil()); //.toDouble());
//     //   weightList.add((formatedWeight + 5.0).ceil()); //.toDouble());
//     //   currentWeight += (real5lbWeight * 2);
//     //   currentWeight = currentWeight.ceilToDouble();
//     // }
//   }

//   ///
//   /// Use jsonEncode() function to create the Picker Data List.
//   ///
//   return "[" + jsonEncode(weightList) + "]";
// }

import 'dart:convert';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:flutter/material.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gIronMaster45LbWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gIronMaster45LbWeightIndexFromPicker2(
    int weight, double user5lbPlateWeight) {
  List<dynamic> theList =
      new JsonDecoder().convert(gGetCurrent45lbWeightList(user5lbPlateWeight));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gIronMaster75LbWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gIronMaster75LbWeightIndexFromPicker2(
    int weight, double user5lbPlateWeight) {
  List<dynamic> theList =
      new JsonDecoder().convert(gGetCurrent75lbWeightList(user5lbPlateWeight));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gIronMaster120LbWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gIronMaster120LbWeightIndexFromPicker2(
    int weight, double user5lbPlateWeight) {
  List<dynamic> theList =
      new JsonDecoder().convert(gGetCurrent120lbWeightList(user5lbPlateWeight));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gIronMaster165LbWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gIronMaster165LbWeightIndexFromPicker2(
    BuildContext context, int weight, double user5lbPlateWeight) {
  List<dynamic> theList = new JsonDecoder()
      .convert(gGetCurrent165lbWeightList(context, user5lbPlateWeight));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gMoJeer20KgWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gMoJeer20KgWeightIndexFromPicker2(BuildContext context, int weight) {
  // BuildContext context, int weight, double user5lbPlateWeight) {
  List<dynamic> theList =
      new JsonDecoder().convert(gGetCurrentMoJeer20kgWeightList(2.0));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:  gMoJeer40KgWeightIndexFromPicker2
///
/////////////////////////////////////////////////////////////////////////////////////////////////
int gMoJeer40KgWeightIndexFromPicker2(BuildContext context, int weight) {
  // BuildContext context, int weight, double user5lbPlateWeight) {
  List<dynamic> theList =
      new JsonDecoder().convert(gGetCurrentMoJeer40kgWeightList(2.0));

  int index = 0;
  for (index = 0; index < theList[0].length; ++index) {
    if (theList[0][index].toInt() == weight) {
      return index;
    }
  }

  return 0;
}

// NewNumberPicker gShowIronMasterWeightCorrectionPickerArray(BuildContext context,
//     // int queryEnteredWeight,
//     // int oneRepMax,
//     // double percent,
//     // AnimatedBarbell animatedBarbell,
//     {Function onConfirm,
//     bool hideHeader = true,
//     String title = "",
//     int initialWholeValue = 0,
//     int initialFactionValue = 0}) {
//   final mediaQuery = MediaQuery.of(context);

//   double textScaleFactor = 0.05;

//   if (Platform.isIOS && giSiPadDevice == true) {
//     textScaleFactor =
//         (mediaQuery.orientation == Orientation.portrait) ? 0.03 : 0.02;
//   }

// //   const numberPickerData = '''
// // [
// //     [
// //         -5.0,
// //         -2.5,
// //         0.0,
// //         2.5,
// //         5.0
// //     ]
// // ]
// //     ''';
//   const fivePoundPlateCorrectionPickerData = '''
// [
//     [
//         4.5,
//         4.6,
//         4.7,
//         4.8,
//         4.9,
//         5.0,
//         5.1,
//         5.2,
//         5.3,
//         5.4,
//         5.5
//     ]
// ]
//     ''';

//   return NewNumberPicker(
//       title: new Text(title,
//           style: TextStyle(
//               color: Colors.orangeAccent,
//               fontSize: mediaQuery.size.width * textScaleFactor,
//               fontWeight: FontWeight.bold)),
//       containerColor: Colors.black26,
//       textStyle: TextStyle(
//           color: Colors.orangeAccent,
//           fontSize: mediaQuery.size.width * textScaleFactor,
//           fontWeight: FontWeight.bold),
//       columnPadding: EdgeInsets.all(4),
//       itemExtent: 54,
//       backgroundColor: Colors.black26,
//       initialWholeValue: initialWholeValue,
//       initialFactionValue: initialFactionValue,
//       adapter: NewNumberPickerDataAdapter<String>(
//           pickerdata: new JsonDecoder()
//               .convert(fivePoundPlateCorrectionPickerData), //numberPickerData),
//           isArray: true),
//       hideHeader: hideHeader,
//       looping: false,
//       onConfirm: (NewNumberPicker picker, List value) {
//         // print(value.toString());
//         // print(picker.getSelectedValues());
//         onConfirm(picker);
//       });
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gIronMasterWeightCorrectionIndexFromPicker
// ///
// ///   Special Information:  This class is used in grouped_checkbox.dart
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// int gIronMasterWeightCorrectionIndexFromPicker(double correction) {
//   // List<double> list = [-5.0, -2.5, 0.0, 2.5, 5.0];
//   List<double> list = [4.5, 4.6, 4.7, 4.8, 4.9, 5.0, 5.1, 5.2, 5.3, 5.4, 5.5];
//   for (int index = 0; index < list.length; index++) {
//     if (list[index] == correction) {
//       return index;
//     }
//   }

//   return 0;
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// List<WeightPlatesItemClass> gGetSelectedWeightRackList(BuildContext context) {
//   List<WeightPlatesItemClass> weightPlatesList;

//   switch (
//       Provider.of<WeightRackBlocNotifier>(context, listen: false).dumbbellSet) {
//     case 0:
//       weightPlatesList =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .ironMaster45lbPlatesList;
//       weightPlatesList[1].weight =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .weightCorrectionValue;
//       break;
//     case 1:
//       weightPlatesList =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .ironMaster75lbPlatesList;
//       weightPlatesList[1].weight =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .weightCorrectionValue;
//       break;
//     case 2:
//       weightPlatesList =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .ironMaster120lbPlatesList;

//       weightPlatesList[2].weight =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .weightCorrectionValue;
//       break;
//     case 3:
//       weightPlatesList =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .ironMaster165lbPlatesList;
//       break;
//     default:
//       weightPlatesList =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .ironMaster75lbPlatesList;
//       weightPlatesList[2].weight =
//           Provider.of<WeightRackBlocNotifier>(context, listen: false)
//               .weightCorrectionValue;
//       break;
//   }

//   return weightPlatesList;
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// ///
// ///   Function:  gCalculateAndUpdateWeightRackList
// ///
// /////////////////////////////////////////////////////////////////////////////////////////////////
// int gCalculateAndUpdateWeightRackList(
//     BuildContext context, int targetWeight, double real5lbWeight) {
//   List<WeightPlatesItemClass> theRack = gGetSelectedWeightRackList(context);

//   int index5lbPlate = 0;
//   int index2Point5Plate = 0;
//   // Get index of 2.5lb and 5lb plates based on current selected DB Set
//   if (Provider.of<WeightRackBlocNotifier>(context, listen: false).dumbbellSet >=
//       2) {
//     index5lbPlate = 2;
//     index2Point5Plate = 3;
//   } else {
//     index5lbPlate = 1;
//     index2Point5Plate = 2;
//   }

//   // 5lb dumbbell used no plates or Lock Screws, and
//   // 10lb dumbbells only use the Screw Locks on each side.
//   if (targetWeight <= 10) {
//     return targetWeight;
//   }

//   // 15lb dumbbells only use the 2.5 plates and Screw Locks on each side.
//   if (targetWeight == 15) {
//     theRack[index2Point5Plate].usedCount = 1;
//     return targetWeight;
//   }

//   // Update the racks plate counts based on target weight

//   // List<dynamic> weightList = [5, 10, 15];
//   const int TOTAL_5LB_PLATES_PER_DUMBBELL = 3;
//   // Iterate and determine how mnay 5lb plates are used for passed-in
//   // target weight.
//   double currentWeight = 10; // handle plus screw locks
//   for (int i = 1; i <= TOTAL_5LB_PLATES_PER_DUMBBELL; ++i) {
//     // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//     currentWeight += (real5lbWeight * 2);

//     // double formatedWeight = 10.0 + (real5lbWeight * 2 * i);
//     double fraction = currentWeight - currentWeight.truncate();
//     if (fraction < 0.5) {
//       // weightList.add(formatedWeight.floor().toInt());

//       // Track current weight.
//       currentWeight = currentWeight.floorToDouble();

//       // 5lb is the 2.5lb plates x 2, dart formats fractions to 0
//       // when using 5 instead of (2.5 * 2)
//       // weightList.add(formatedWeight.floor().toInt() + (5));
//     } else {
//       // Track current weight.
//       currentWeight = currentWeight.ceilToDouble();

//       // weightList.add(formatedWeight.ceil().toInt());
//       // // 5lb is the 2.5lb plates x 2, dart formats fractions to "5"
//       // // when using 5, but formats to "5.0" if using (2.5 * 2).
//       // weightList.add(formatedWeight.ceil().toInt() + (5));
//     }

//     if (currentWeight == targetWeight || (currentWeight + 5) == targetWeight) {
//       // Update the rack's 5lb plate count.
//       theRack[index5lbPlate].usedCount = i;

//       if ((currentWeight + 5) == targetWeight) {
//         theRack[index2Point5Plate].usedCount = 1;
//       }

//       break;
//     }
//   }

//   return targetWeight;
// }
