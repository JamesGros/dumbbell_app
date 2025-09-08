// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:io';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/loadbarbell_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/loadbarbell_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/settings_view.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/show_picker_dialog_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/weightrack_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/menu_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/preference_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/animated_barbell.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:provider/provider.dart';

class LoadBarbellView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoadBarbellView(),
      );
  const LoadBarbellView({
    super.key,
  });

  @override
  LoadBarbellViewState createState() => LoadBarbellViewState();
}

///
/// LoadBarbellViewState class
///
class LoadBarbellViewState extends State<LoadBarbellView>

    ///
    /// Test Animation of Rotate/Translate - BEGIN
    ///
    /// https://stackoverflow.com/questions/61984955/how-to-apply-translate-and-rotate-animation-in-flutter-to-create-a-cards-being
    ///
    with
        // SingleTickerProviderStateMixin
        TickerProviderStateMixin {
  ///
  /// Change Notifiers
  ///
  static WeightRackBlocNotifier weightrackNotifier = WeightRackBlocNotifier();
  // get getWeightrackNotifier => weightrackNotifier;

  // /// IRONMAST
  // /// 1st instance (left dumbbell) for IRON MASTER
  // ///
  // static final AnimatedBarbell _barbell = AnimatedBarbell(
  //     // ironMasterHandle: IronMasterHandleType.IRONMASTER_LEFT_HANDLE,
  //     );
  // AnimatedBarbell getAnimatedBarbell1() {
  //   return _barbell;
  // }

  /// IRONMAST
  /// Create a 2nd instance (right dumbbell) for IRON MASTER
  ///
  static final AnimatedBarbell _barbell2 = AnimatedBarbell(
      // ironMasterHandle: IronMasterHandleType.IRONMASTER_RIGHT_HANDLE
      );
  AnimatedBarbell getAnimatedBarbell2() {
    return _barbell2;
  }
// IRON MASTER - Initialize this in initState
  // static double _barbellWidth = 0;

  ////////////////////////////////////////////////////////////////////////////////
  /// Function: setBarbellProperties
  /// Purpose:
  /// Parameters:
  /// Notes:
////////////////////////////////////////////////////////////////////////////////
  setBarbellProperties(AnimatedBarbell theBarbell, Color color, double width,
      double height, double weight) {
    theBarbell.myStateInstance.barbellProperty.color = color;
    theBarbell.myStateInstance.barbellProperty.widthBarbell = width;
    theBarbell.myStateInstance.barbellProperty.heightBarbell = height;
    theBarbell.myStateInstance.barbellProperty.desiredWeight = weight;
  }
  //   setBarbellProperties(
  //     Color color, double width, double height, double weight) {
  //   _barbell.barbellProperty.color = color;
  //   _barbell.barbellProperty.widthBarbell = width;
  //   _barbell.barbellProperty.heightBarbell = height;
  //   _barbell.barbellProperty.desiredWeight = weight;
  // }

  // static final KeyedSubtree barbellKeyedSubtree = KeyedSubtree(
  //     key: MyKeys.myKey1, //ObjectKey(0),
  //     child: _barbell);

  // Constructor

  // static final KeyedSubtree _persistentBarbell = KeyedSubtree(
  // key:  UniqueKey(), child: _barbell);

  String title = '';
  double _percent = 0.0;
  int _oneRepMax = 0;

  // ///
  // /// Currently selected set.  Changes when the user taps the Sets button to load the LoadBarbellView.
  // ///
  late ScrollController _scrollControllerForPlateLoadedList;
  late ScrollController _scrollControllerForPlateAvailableList;

  bool _initialized = false;

  // Queries the user for weight to load on barbell.
  final TextEditingController enterWeightTextEditController =
      TextEditingController();

  // int _queryEnteredWeightTopLeft = 55;
  int _queryEnteredWeightBottomRight = 0;

  // int _ironMasterTopViewWeightIndex = 0;
  int _ironMasterBottomViewWeightIndex = 0;

  // Initialized when DB Set changed
  int _ironMasterWeightIndexMax = 0;

  // bool _useTopLeftHeavy22lbPlates = true;
  bool _useBottomRightHeavy22lbPlates = true;

  bool bRotateIronMasterView = false;

  // bool _menuHiddenOnSubmitted = false;
  late FocusNode _myFocusNode;
  // late OverlayEntry _overlayEntry;

  // TEST
  // CarouselController buttonCarouselController = CarouselController();

  int _currentDumbbellSet = 0;
  double _weightCorrectionValue = 5.0;

  ///
  /// MenuNotifier is not used for Iron Master App
  ///
  // ///
  // /// A text input listener to hide the user opens the Main Menu
  // ///
  // void _enterWeightTextListener() {
  //   /// Hide the main menu if it is open.
  //   /// Do this only once, because the listener is called periodically.
  //   if (Provider.of<MenuNotifier>(context, listen: false).stateHideMenu ==
  //           false &&
  //       _menuHiddenOnSubmitted == false) {
  //     Provider.of<MenuNotifier>(context, listen: false).stateHideMenu = true;
  //   }

  //   /// Reset _menuHiddenOnSubmitted flag if TextField widget has no focus.
  //   if (_myFocusNode.hasFocus == false) {
  //     _menuHiddenOnSubmitted = false;
  //   }
  // }

  // @override
  // void didUpdateWidget(LoadBarbellView oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  ///
  /// Test Animation of Rotate/Translate - START
  ///
  late AnimationController _rotateDumbbellAnimController;
  late AnimationController _rotateWeightTextAnimController;

  // Animation<double> rot;
  // Tween<double> rotateAnimation;
  // Animation<double> trasl;

  // void setRotation(int degrees) {
  //   final angle = degrees * pi / 180;

  //   rotateAnimation = Tween<double>(begin: 0, end: angle);
  // }

  ///
  /// Test Animation of Rotate/Translate - END
  ///
  @override
  void initState() {
    super.initState();

    // ///
    // /// Test Animation of Rotate/Translate - START
    // ///
    _rotateDumbbellAnimController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _rotateWeightTextAnimController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    // rot = Tween<double>(
    //   begin: 0,
    //   end: 2 * pi,
    // ).animate(_rotateAnimController);

    // trasl = Tween<double>(
    //   begin: 0,
    //   end: 300,
    // ).animate(_rotateAnimController);

    // _rotateAnimController.repeat();

    ///
    /// Test Animation of Rotate/Translate - END
    ///
    // ResoCoder:  Used the,
    //            TextField(
    //              decoration: InputDecoration(border: OutlineInputBorder(),
    //              hintText: 'Input Weight'),
    // to display in input field.
    //enterWeightTextEditController.text = "0";

    ///
    /// MenuNotifier is not used for Iron Master App
    ///
    // enterWeightTextEditController.addListener(_enterWeightTextListener);

    _myFocusNode = FocusNode();

    // /// The keyboard is handled differently on IOS, the "DONE"
    // /// button is displayed using the InputDoneView class.
    // /// Credits:  Ramankit Singh
    // /// URL: https://blog.usejournal.com/keyboard-done-button-ux-in-flutter-ios-app-3b29ad46bacc
    // if (Platform.isIOS) {
    //   _myFocusNode.addListener(() {
    //     bool hasFocus = _myFocusNode.hasFocus;
    //     if (hasFocus)
    //       showOverlay(context);
    //     else
    //       removeOverlay();
    //   });

    //   KeyboardVisibilityNotification().addNewListener(
    //     onHide: () {
    //       removeOverlay();
    //     },
    //   );
    // }

    _scrollControllerForPlateLoadedList = ScrollController();
    _scrollControllerForPlateAvailableList = ScrollController();

    // _barbellWidth = MediaQuery.of(context).size.width;

    ///
    /// IRON MASTER - Moved initializstion of notifier elements to weightrack_bloc
    ///               WeightrackInitializePlate() state method.
    ///
    // Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //     .isDumbbellSingleView = gSharedPrefs.dumbbellSingleViewMode;
    // Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //     .weightCorrectionValue = gSharedPrefs.weighed5LbPlate;
    // Provider.of<WeightRackBlocNotifier>(context, listen: false).dumbbellSet =
    //     gSharedPrefs.dumbbellSetChoice;

    _ironMasterWeightIndexMax = gGetDumbbellSetMaxIndex(context);
    // Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //     .ironMasterWeightMaxIndex = _ironMasterWeightIndexMax;
    gIronMasterWeightMaxIndex = _ironMasterWeightIndexMax;
  }

  // /// The keyboard is handled differently on IOS, the "DONE"
  // /// button is displayed using the InputDoneView class.
  // /// Credits:  Ramankit Singh
  // /// URL: https://blog.usejournal.com/keyboard-done-button-ux-in-flutter-ios-app-3b29ad46bacc
  // showOverlay(BuildContext context) {
  //   if (_overlayEntry != null) return;

  //   ///
  //   /// Hide the main menu.
  //   ///
  //   Provider.of<MenuNotifier>(context, listen: false).stateHideMenu = true;

  //   OverlayState overlayState = Overlay.of(context);
  //   _overlayEntry = OverlayEntry(builder: (context) {
  //     return Positioned(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //         right: 0.0,
  //         left: 0.0,
  //         child: InputDoneView(
  //             onDonePressed: onSubmittedWeight,
  //             textEditController: enterWeightTextEditController));
  //   });

  //   overlayState.insert(_overlayEntry);
  // }

  /// The keyboard is handled differently on IOS, the "DONE"
  /// button is displayed using the InputDoneView class.
  /// Credits:  Ramankit Singh
  /// URL: https://blog.usejournal.com/keyboard-done-button-ux-in-flutter-ios-app-3b29ad46bacc
  // removeOverlay() {
  //   if (_overlayEntry != null) {
  //     ///
  //     /// Show the main menu.
  //     ///
  //     Provider.of<MenuNotifier>(context, listen: false).stateHideMenu = false;
  //     _overlayEntry.remove();
  //     _overlayEntry = null;
  //   }
  // }

  @override
  void dispose() {
    /// Clean up the text input controller.
    enterWeightTextEditController.dispose();

    _myFocusNode.dispose();

    _scrollControllerForPlateLoadedList.dispose();
    _scrollControllerForPlateAvailableList.dispose();

    _rotateDumbbellAnimController.dispose();
    _rotateWeightTextAnimController.dispose();
    super.dispose();
  }

  // //
  // // Callback functon mapped to TextField::onSubmitted
  // //
  // void onSubmittedWeight(String value) {
  //   _queryEnteredWeightTopLeft = 0;

  //   /// TODO - In the future, use ResoCoder Clean Architecture to isolate
  //   ///        the exception handle in the Domain Layer.
  //   // Validate incoming value
  //   if (value != null && int.tryParse(value) != null) {
  //     //int.parse(value) != null) {
  //     _queryEnteredWeightTopLeft = int.parse(value); //int.parse(value);
  //   }

  //   /// Un-hide the main menu if it is hidden.
  //   //if (_myFocusNode.hasFocus == false) {
  //   if (_menuHiddenOnSubmitted == false) {
  //     Provider.of<MenuNotifier>(context, listen: false).stateHideMenu = false;
  //     _menuHiddenOnSubmitted = true;
  //   }

  //   /// Reset the BarbellDisplayListBlocNotifier display list
  //   // resetBarbellPlatesDisplayList(_barbell);
  //   resetBarbellPlatesDisplayList(_barbell2);

  //   // ResoCoder: Clear the text input field when user is done entering weight
  //   enterWeightTextEditController.clear();
  // }

  // /// IRON MASTER
  // //
  // // Callback functon mapped to TextField::onSubmitted
  // //
  // void onSubmittedWeight2(String value) {
  //   _queryEnteredWeightBottomRight = 0;

  //   /// TODO - In the future, use ResoCoder Clean Architecture to isolate
  //   ///        the exception handle in the Domain Layer.
  //   // Validate incoming value
  //   if (value != null && int.tryParse(value) != null) {
  //     //int.parse(value) != null) {
  //     _queryEnteredWeightBottomRight = int.parse(value); //int.parse(value);
  //   }

  //   /// Un-hide the main menu if it is hidden.
  //   //if (_myFocusNode.hasFocus == false) {
  //   if (_menuHiddenOnSubmitted == false) {
  //     Provider.of<MenuNotifier>(context, listen: false).stateHideMenu = false;
  //     _menuHiddenOnSubmitted = true;
  //   }

  //   /// IRON MASTER
  //   resetBarbellPlatesDisplayList(_barbell2);

  //   // ResoCoder: Clear the text input field when user is done entering weight
  //   enterWeightTextEditController.clear();
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  _displayQueryEnterWeight
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  /// MenuNotifier is not used for Iron Master App
  ///
  // Widget _displayQueryEnterWeight() {
  //   return Column(
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.all(5),
  //       ),

  //       // Add query the user for weight Card.
  //       Card(
  //         elevation: 8.0,
  //         margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
  //         color: Colors.lightBlue,
  //         // borderOnForeground: true,
  //         child: Container(
  //           decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, 0.9)),
  //           child: ListTile(
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),

  //             // title: (Provider.of<WeightRackBlocNotifier>(context,
  //             //                 listen: false)
  //             //             .kiloPoundsSelectionSwitch
  //             //             .isSwitchedOn ==
  //             //         true)
  //             //     ? Container(
  //             //         width: MediaQuery.of(context).size.width * .25,
  //             //         child: Text("Enter Weight (lb)",
  //             //             textAlign: TextAlign.center,
  //             //             style: TextStyle(
  //             //                 color: Colors.white,
  //             //                 fontSize: MediaQuery.of(context).size.width * .05,
  //             //                 fontWeight: FontWeight.bold)),
  //             //       )
  //             //     : Container(
  //             //         width: MediaQuery.of(context).size.width * .25,
  //             //         child: Text(
  //             //           "Enter Weight (kg)",
  //             //           textAlign: TextAlign.center,
  //             //           style: TextStyle(
  //             //               color: Colors.white,
  //             //               fontSize: MediaQuery.of(context).size.width * .05,
  //             //               fontWeight: FontWeight.bold),
  //             //         ),
  //             //       ),
  //             //Theme.of(context).textTheme.body1,,),
  //             subtitle: Container(
  //               margin: const EdgeInsets.all(8.0),
  //               padding: const EdgeInsets.all(3.0),
  //               decoration:
  //                   BoxDecoration(border: Border.all(color: Colors.blueAccent)),
  //               child:

  //                   /// The keyboard is handled differently on IOS, the "DONE"
  //                   /// button is displayed using the InputDoneView class.
  //                   /// Credits:  Ramankit Singh
  //                   /// URL: https://blog.usejournal.com/keyboard-done-button-ux-in-flutter-ios-app-3b29ad46bacc
  //                   Platform.isIOS
  //                       ? CupertinoTextField(
  //                           placeholder: (Provider.of<WeightRackBlocNotifier>(
  //                                           context,
  //                                           listen: false)
  //                                       .kiloPoundsSelectionSwitch
  //                                       .isSwitchedOn ==
  //                                   true)
  //                               ? "Enter Weight (lb)"
  //                               : "Enter Weight (kg)",
  //                           textAlign: TextAlign.center,
  //                           // decoration: BoxDecoration(
  //                           //     border: Border.all(
  //                           //         color: Theme.of(context).accentColor,
  //                           //         width: 3.0)),
  //                           // hintText: 'Input Weight',
  //                           focusNode: _myFocusNode,
  //                           controller: enterWeightTextEditController,
  //                           keyboardType: TextInputType.number,
  //                           inputFormatters: <TextInputFormatter>[
  //                             FilteringTextInputFormatter.digitsOnly
  //                             // WhitelistingTextInputFormatter.digitsOnly
  //                           ],
  //                         )
  //                       : TextField(
  //                           // ResoCoder:  START
  //                           decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: (Provider.of<WeightRackBlocNotifier>(
  //                                             context,
  //                                             listen: false)
  //                                         .kiloPoundsSelectionSwitch
  //                                         .isSwitchedOn ==
  //                                     true)
  //                                 ? "Enter Weight (lb)"
  //                                 : "Enter Weight (kg)",
  //                           ),

  //                           // 'Enter Weight'),
  //                           // ResoCoder:  END
  //                           focusNode: _myFocusNode,
  //                           cursorColor: Colors.red,
  //                           cursorRadius: Radius.circular(16.0),
  //                           cursorWidth: 6.0,
  //                           // maxLength: 4,
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight
  //                                   .bold), //Theme.of(context).textTheme.body1,
  //                           controller: enterWeightTextEditController,
  //                           autofocus: false,
  //                           keyboardType: TextInputType.number,
  //                           inputFormatters: <TextInputFormatter>[
  //                             FilteringTextInputFormatter.digitsOnly
  //                             // WhitelistingTextInputFormatter.digitsOnly
  //                           ],
  //                           // autofocus: false,
  //                           onSubmitted: onSubmittedWeight,
  //                           onTap: () {
  //                             Provider.of<MenuNotifier>(context, listen: false)
  //                                 .stateHideMenu = true;
  //                           },
  //                         ),
  //             ),
  //           ),
  //         ),
  //       ),

  //       Padding(
  //         padding: EdgeInsets.all(3),
  //       ),

  //       // Padding(
  //       //   padding: EdgeInsets.all(3),
  //       // ),
  //     ],
  //   );
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  _buildWeightPlate
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildWeightPlate(AnimatedBarbell theBarbell, double desiredWeight) {
    setBarbellProperties(
        theBarbell,
        Colors.grey,
        gDumbbellDisplayAreaWidth, // Initialized in main.dart
        gBarbellHeight, // Initialized in main.dart
        desiredWeight);

    // setBarbellProperties(
    //     Colors.grey,
    //     MediaQuery.of(context).size.width +
    //         MediaQuery.of(context).devicePixelRatio,
    //     20,
    //     desiredWeight);

    return theBarbell;
  }

  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///   Function:
  // ///
  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // List<WeightPlatesItemClass> _getSelectedWeightRackList() {
  //   List<WeightPlatesItemClass> weightPlatesList;
  //   switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //       .dumbbellSet) {
  //     case 0:
  //       weightPlatesList =
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .ironMaster45lbPlatesList;
  //       break;
  //     case 1:
  //       weightPlatesList =
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .ironMaster75lbPlatesList;
  //       break;
  //     case 2:
  //       weightPlatesList =
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .ironMaster120lbPlatesList;
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
  //       break;
  //   }

  //   return weightPlatesList;
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  Resets the BarbellDisplayListBlocNotifier display list
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  void resetBarbellPlatesDisplayList(AnimatedBarbell theBarbell) {
    ///
    /// IRON MASTER
    ///

    // Immediately trigger the event
    BlocProvider.of<WeightrackBloc>(context).add(WeightrackUpdatePlate(
        context,
        _queryEnteredWeightBottomRight,
        _oneRepMax,
        _percent,
        _barbell2,
        false));
  }

  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///   Function:
  // ///
  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // int _getIronMasterDumbbellSetMaxIndex(BuildContext context) {
  //   switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //       .dumbbellSet) {
  //     case 0:
  //       List<dynamic> theList = JsonDecoder().convert(gGetCurrent45lbWeightList(
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .weightCorrectionValue));
  //       return theList[0].length;
  //       break;
  //     case 1:
  //       List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .weightCorrectionValue));
  //       return theList[0].length;
  //       break;
  //     case 2:
  //       List<dynamic> theList = JsonDecoder().convert(
  //           gGetCurrent120lbWeightList(
  //               Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                   .weightCorrectionValue));
  //       return theList[0].length;
  //       break;
  //     case 3:
  //       List<dynamic> theList = JsonDecoder().convert(
  //           gGetCurrent165lbWeightList(
  //               context,
  //               Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                   .weightCorrectionValue));
  //       return theList[0].length;
  //       break;
  //     default:
  //       List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
  //           Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //               .weightCorrectionValue));
  //       return theList[0].length;
  //       break;
  //   }
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  int _getIronMasterDumbbellSetValueAtIndex(BuildContext context, int index) {
    // return 1;

    switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
        .dumbbellSet) {
      case 0:
        List<dynamic> theList = JsonDecoder().convert(gGetCurrent45lbWeightList(
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      case 1:
        List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      case 2:
        List<dynamic> theList = JsonDecoder().convert(
            gGetCurrent120lbWeightList(
                Provider.of<WeightRackBlocNotifier>(context, listen: false)
                    .weightCorrectionValue));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      case 3:
        List<dynamic> theList = JsonDecoder().convert(
            gGetCurrent165lbWeightList(
                context,
                Provider.of<WeightRackBlocNotifier>(context, listen: false)
                    .weightCorrectionValue));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      case 4: // MoJeer 20Kg
        List<dynamic> theList = JsonDecoder().convert(

            ///
            /// MoJeer doesn't use correction value - always 2kg plates
            ///
            gGetCurrentMoJeer20kgWeightList(2.0));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      case 5: // MoJeer 40Kg
        List<dynamic> theList = JsonDecoder().convert(

            ///
            /// MoJeer doesn't use correction value - always 2kg plates
            ///
            gGetCurrentMoJeer40kgWeightList(2.0));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
      default:
        List<dynamic> theList = JsonDecoder().convert(gGetCurrent75lbWeightList(
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue));
        // Validate index
        if (index >= theList[0].length) {
          index = theList[0].length - 1;
        }
        return theList[0][index].toInt();
        break;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function: _getIronMasterWeightIndex
  ///
  ///   Returns the weight index for the IronMaster dumbbell set
  ///   based on the weight and the dumbbell set.
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  int _getIronMasterWeightIndex(BuildContext context, int weight) {
    switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
        .dumbbellSet) {
      case 0:
        return gIronMaster45LbWeightIndexFromPicker2(
            weight,
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue);
      case 1:
        return gIronMaster75LbWeightIndexFromPicker2(
            weight,
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue);
      case 2:
        return gIronMaster120LbWeightIndexFromPicker2(
            weight,
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue);
      case 3:
        return gIronMaster165LbWeightIndexFromPicker2(
            context,
            weight,
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue);
      case 4: // MoJeer 20Kg
        return gMoJeer20KgWeightIndexFromPicker2(context, weight);

      case 5: // MoJeer 40Kg
        return gMoJeer40KgWeightIndexFromPicker2(context, weight);
      default:
        return gIronMaster45LbWeightIndexFromPicker2(
            weight,
            Provider.of<WeightRackBlocNotifier>(context, listen: false)
                .weightCorrectionValue);
        break;
    }
    // return 0;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  This callback function is invoked when the User changes the dumbbell set
  ///              from the grouped_checkbox.dart widget.
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Container _dumbbellSetChangedCallbackFunction(BuildContext context) {
    if (_currentDumbbellSet !=
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .dumbbellSet) {
      ///
      /// IRON MASTER - Update both dumbbells
      ///
      // _queryEnteredWeightTopLeft = 0;
      // _queryEnteredWeightBottomRight =
      //     Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //         .desiredWeight
      //         .toInt();

      // JG DEBUG

      // Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //     .desiredWeight = 0;
      // _queryEnteredWeightBottomRight = 0;

      // _ironMasterSingleViewWeightIndex = 0;

      _ironMasterWeightIndexMax = gGetDumbbellSetMaxIndex(context);

      // Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //     .ironMasterWeightMaxIndex = _ironMasterWeightIndexMax;
      gIronMasterWeightMaxIndex = _ironMasterWeightIndexMax;

      // Immediately trigger the event
      BlocProvider.of<WeightrackBloc>(context).add(WeightrackUpdatePlate(
          context,
          _queryEnteredWeightBottomRight,
          _oneRepMax,
          _percent,
          _barbell2,
          // false indicates Bottom/Right dumbbell

          false));

      _currentDumbbellSet =
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .dumbbellSet;

      // Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //     .dumbbellSetChanged = false;

      ///
      /// Move this code outside the widget tree build() context.
      ///

      // onAlertWorkoutDescription(
      //     context,
      //     "Changed DB Set",
      //     "Changed to" +
      //         Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //             .dumbbellSet
      //             .toString());
    }

    return Container();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  This callback function is invoked when the User changes the dumbbell set
  ///              from the grouped_checkbox.dart widget.
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Container _weightCorrectionValueChangedCallbackFunction(
      BuildContext context) {
    if (_weightCorrectionValue !=
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .weightCorrectionValue) {
      ///
      /// IRON MASTER - Update both dumbbells
      ///
      /// Do not reset current selected weight when 5lb correction value changed.
      // _queryEnteredWeightTopLeft = 0;
      // _queryEnteredWeightBottomRight = 0;

      _ironMasterWeightIndexMax = gGetDumbbellSetMaxIndex(context);

      gIronMasterWeightMaxIndex = _ironMasterWeightIndexMax;

      // ///
      // /// Update displayed desired weight with new 5lb correction value.
      // ///
      // _queryEnteredWeightTopLeft = _getIronMasterDumbbellSetValueAtIndex(
      //     context, gIronMasterTopViewWeightIndex);

      // ///
      // /// Update displayed desired weight with new 5lb correction value.
      // ///
      // _queryEnteredWeightBottomRight = _getIronMasterDumbbellSetValueAtIndex(
      //     context, gIronMasterBottomViewWeightIndex);

      // Immediately trigger the event
      BlocProvider.of<WeightrackBloc>(context).add(WeightrackUpdatePlate(
          context,
          _queryEnteredWeightBottomRight,
          _oneRepMax,
          _percent,
          _barbell2,
          // false indicates Bottom/Right dumbbell

          false));

      _weightCorrectionValue =
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .weightCorrectionValue;
    }

    return Container();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  This callback function is invoked when the User changes the dumbbell set
  ///              from the grouped_checkbox.dart widget.
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Container _useBottomRight22lbCheckboxChangedCallbackFunction(
      BuildContext context) {
    if (_useBottomRightHeavy22lbPlates !=
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .useHeavy22lbPlatesBottomRight) {
      ///
      /// IRON MASTER - Update both dumbbells
      ///

      _useBottomRightHeavy22lbPlates =
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .useHeavy22lbPlatesBottomRight;

      // BlocProvider.of<WeightrackBloc>(context)
      //   ..add(WeightrackUpdatePlate(
      //       context, _queryEnteredWeight, _oneRepMax, _percent, _barbell));

      // Immediately trigger the event
      BlocProvider.of<WeightrackBloc>(context).add(WeightrackUpdatePlate(
          context,
          _queryEnteredWeightBottomRight,
          _oneRepMax,
          _percent,
          _barbell2,
          // false indicates Bottom/Right dumbbell

          false));
    }

    return Container();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  This callback function is invoked when the User changes the dumbbell
  ///              weight via Bottom left/right buttons.
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Container _useBottomLeftRightButtonPressedCallbackFunction(
      BuildContext context) {
    if (_ironMasterBottomViewWeightIndex != gIronMasterBottomViewWeightIndex) {
      ///
      /// IRON MASTER - Update both dumbbells
      ///

      _ironMasterBottomViewWeightIndex = gIronMasterBottomViewWeightIndex;

// int weight = _getIronMasterDumbbellSetValueAtIndex(context);
//                   print("weight = $weight");

//                   onSubmittedWeight2(weight.toString());

      _queryEnteredWeightBottomRight = _getIronMasterDumbbellSetValueAtIndex(
          context, _ironMasterBottomViewWeightIndex);

      /// IRON MASTER
      resetBarbellPlatesDisplayList(_barbell2);

      // // _barbell is the Top Left
      // BlocProvider.of<WeightrackBloc>(context)
      //   ..add(WeightrackUpdatePlate(
      //       context,
      //       _queryEnteredWeightTopLeft,
      //       _oneRepMax,
      //       _percent,
      //       _barbell,
      //       // true indicates Top/Left dumbbell
      //       true));
    }

    return Container();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:
  ///
/////////////////////////////////////////////////////////////////////////////////////////////////
  Checkbox _displayBottomRightUse22lbCheckbox(BuildContext context) {
    return Checkbox(
      // key: UniqueKey(),
      // key: MyKeys.myCheckboxKey2,

      // autofocus: true,
      activeColor: Colors.green,
      checkColor: Colors.white,
      value: Provider.of<WeightRackBlocNotifier>(
        context,
        listen: false,
      ).useHeavy22lbPlatesBottomRight,
      onChanged: (bool? value) {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .useHeavy22lbPlatesBottomRight = value!;
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // // if (Provider.of<MenuNotifier>(context, listen: false).statePreviousPage ==
    // //     MainMeuWorkoutsEnum.HOME) {
    // if (Provider.of<MenuNotifier>(context, listen: false).statePreviousPage ==
    //         MainMeuWorkoutsEnum.HATCH ||
    //     Provider.of<MenuNotifier>(context, listen: false).statePreviousPage ==
    //         MainMeuWorkoutsEnum.WENDLER) {
    //   // Set title from the previous page's title (WENDLER or HATCH).
    //   title = Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
    //       .stateTitle;
    // } else {
    title = "IM DUMBBELL\nPLATE CALCULATOR";
    // title = "IRON MASTER\nPLATE CALCULATOR";
    // }

    // _percent = Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
    //     .statePercent;

    // _oneRepMax = Provider.of<LoadBarbellBlocNotifier>(context, listen: false)
    //     .stateOneRepMax;
    // }

    if (_initialized == false) {
      // Immediately trigger the event
      // BlocProvider.of<WeightrackBloc>(context).add(WeightrackInitializePlate(
      //     context,
      //     _queryEnteredWeightTopLeft,
      //     _oneRepMax,
      //     _percent,
      //     _barbell,
      //     // true indicates Top/Left dumbbell
      //     true));
      // Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //     .desiredWeight = gSharedPrefs.desiredWeight;
      _queryEnteredWeightBottomRight = gSharedPrefs.desiredWeight.toInt();
      BlocProvider.of<WeightrackBloc>(context).add(WeightrackInitializePlate(
          context,
          _queryEnteredWeightBottomRight,
          _oneRepMax,
          _percent,
          _barbell2,
          // false indicates Bottom/Right dumbbell
          false));
      // _barbell.myStateInstance.handleType =
      //     IronMasterHandleType.IRONMASTER_LEFT_HANDLE;
      _barbell2.myStateInstance.handleType =
          IronMasterHandleType.IRONMASTER_RIGHT_HANDLE;

      ///
      /// Update the weight index for the bottom view.
      /// This ensures that the bottom view is updated with the correct weight index.
      /// when the App is reinitialized by the User.
      ///
      gIronMasterBottomViewWeightIndex =
          _getIronMasterWeightIndex(context, _queryEnteredWeightBottomRight);

      // Provider.of<WeightRackBlocNotifier>(
      //   context,
      //   listen: false,
      // ).ironMasterBottomViewWeightIndex = gIronMasterBottomViewWeightIndex;

      ///
      /// Initialize thhe current set, the LoadBarbellBlocNotifier.totalWorkingSetsInfo
      /// reflects the current selected state of "Warm Up" and "Boring But Big".
      ///

      _initialized = true;
    }

    // Immediately trigger the event
    // BlocProvider.of<WeightrackBloc>(context).add(WeightrackChangeBarbell(
    //     context,
    //     _queryEnteredWeightTopLeft,
    //     _barbell,
    //     // true indicates Top/Left dumbbell
    //     true));

    BlocProvider.of<WeightrackBloc>(context).add(WeightrackChangeBarbell(
        context,
        _queryEnteredWeightBottomRight,
        _barbell2,
        // false indicates Bottom/Right dumbbell
        false));

    context.dependOnInheritedWidgetOfExactType();
  }

//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   ///
//   ///   Function:  _displayRotateSymbol
//   ///
//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   Widget _displayRotateSymbol(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         /// manage the state of each value
//         setState(() {
//           bRotateIronMasterView = !bRotateIronMasterView;
//         });
//       },
//       child: (bRotateIronMasterView)
//           ? Icon(Icons.rotate_right_sharp, color: Colors.white, size: 36)
//           : Icon(Icons.rotate_left_sharp, color: Colors.white, size: 36),
//     );
//   }

//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   ///
//   ///   Function:  _displayBottomRightIronMasterPicker
//   ///
//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   void _displayBottomRightIronMasterPicker() {
//     switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
//         .dumbbellSet) {
//       case 0:
//         gShowIronMaster45LbSetPickerArray(
//           context,
//           title: (bRotateIronMasterView == false)
//               ? "Bottom Dumbbell"
//               : "Right Dumbbell",
//           initialWholeValue: gIronMaster45LbWeightIndexFromPicker2(
//               _queryEnteredWeightBottomRight,
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue),
//           // gIronMaster45LbWeightIndexFromPicker(
//           //     _queryEnteredWeight2), // Index 0 equal 5lb
//           // onConfirm: (NewNumberPicker picker) {
//           //   String value = picker.getSelectedValues()[0];
//           //   if (value != null) {
//           //     // _queryEnteredWeight2 = int.parse(value);
//           //     ///
//           //     /// IRON MASTER - Apply User 5lb plate correction weight.
//           //     /// onSubmittedWeight2() requires an int-type string.
//           //     ///
//           //     _queryEnteredWeightBottomRight = double.parse(value).toInt();
//           //     value = _queryEnteredWeightBottomRight.toString();
//           //     onSubmittedWeight2(value);

//           //     ///
//           //     /// Sync-up index value that used when button is pressed in single view mode.
//           //     ///
//           //     _ironMasterBottomViewWeightIndex = _getIronMasterWeightIndex(
//           //         context, _queryEnteredWeightBottomRight);
//           //     // onSubmittedWeight(_barbell2, value);

//           //     // // TODO:  Remove this DEBUG
//           //     // gCalculateAndUpdateWeightRackList(
//           //     //     context, _queryEnteredWeightBottomRight, 5);
//           //   }
//           // },

//           ///
//           /// Show the header inside the dialog
//           ///
//           hideHeader: false,
//           initialFactionValue: 0,
//           userSpecified5lbPlateWeight:
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue,
//         ).showDialog(context);

//         break;
//       case 1:
//         gShowIronMaster75LbSetPickerArray(
//           context,
//           title: (bRotateIronMasterView == false)
//               ? "Bottom Dumbbell"
//               : "Right Dumbbell",
//           // initialWholeValue: gIronMaster75LbWeightIndexFromPicker(
//           //     _queryEnteredWeight2), // Index 0 equal 5lb
//           initialWholeValue: gIronMaster75LbWeightIndexFromPicker2(
//               _queryEnteredWeightBottomRight,
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue),
//           // onConfirm: (NewNumberPicker picker) {
//           //   String value = picker.getSelectedValues()[0];
//           //   if (value != null) {
//           //     ///
//           //     /// IRON MASTER - Apply User 5lb plate correction weight.
//           //     /// onSubmittedWeight2() requires an int-type string.
//           //     ///
//           //     _queryEnteredWeightBottomRight = double.parse(value).toInt();
//           //     value = _queryEnteredWeightBottomRight.toString();
//           //     // _queryEnteredWeight2 = int.parse(value);
//           //     onSubmittedWeight2(value);

//           //     ///
//           //     /// Sync-up index value that used when button is pressed in single view mode.
//           //     ///
//           //     _ironMasterBottomViewWeightIndex = _getIronMasterWeightIndex(
//           //         context, _queryEnteredWeightBottomRight);
//           //     // onSubmittedWeight(_barbell2, value);
//           //   }
//           // },

//           ///
//           /// Show the header inside the dialog
//           ///
//           hideHeader: false,
//           initialFactionValue: 0,
//           userSpecified5lbPlateWeight:
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue,
//         ).showDialog(context);

//         break;

//       case 2:
//         gShowIronMaster120LbSetPickerArray(
//           context,
//           title: (bRotateIronMasterView == false)
//               ? "Bottom Dumbbell"
//               : "Right Dumbbell",
//           initialWholeValue: gIronMaster120LbWeightIndexFromPicker2(
//               _queryEnteredWeightBottomRight,
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue), // Index 0 equal 5lb
//           // onConfirm: (NewNumberPicker picker) {
//           //   String value = picker.getSelectedValues()[0];
//           //   if (value != null) {
//           //     // _queryEnteredWeight2 = int.parse(value);
//           //     ///
//           //     /// IRON MASTER - Apply User 5lb plate correction weight.
//           //     /// onSubmittedWeight2() requires an int-type string.
//           //     ///
//           //     _queryEnteredWeightBottomRight = double.parse(value).toInt();
//           //     value = _queryEnteredWeightBottomRight.toString();
//           //     onSubmittedWeight2(value);

//           //     ///
//           //     /// Sync-up index value that used when button is pressed in single view mode.
//           //     ///
//           //     _ironMasterBottomViewWeightIndex = _getIronMasterWeightIndex(
//           //         context, _queryEnteredWeightBottomRight);
//           //     // onSubmittedWeight(_barbell2, value);
//           //   }
//           // },

//           ///
//           /// Show the header inside the dialog
//           ///
//           hideHeader: false,
//           initialFactionValue: 0,
//           userSpecified5lbPlateWeight:
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue,
//         ).showDialog(context);

//         break;
//       case 3:
//         gShowIronMaster165LbSetPickerArray(
//           context,
//           title: (bRotateIronMasterView == false)
//               ? "Bottom Dumbbell"
//               : "Right Dumbbell",
//           initialWholeValue: gIronMaster165LbWeightIndexFromPicker2(
//               context,
//               _queryEnteredWeightBottomRight,
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue), // Index 0 equal 5lb
//           // onConfirm: (NewNumberPicker picker) {
//           //   String value = picker.getSelectedValues()[0];
//           //   if (value != null) {
//           //     ///
//           //     /// IRON MASTER - Apply User 5lb plate correction weight.
//           //     /// _queryEnteredWeight2 is an int-type, and
//           //     /// onSubmittedWeight2() requires an int-type string.
//           //     ///
//           //     _queryEnteredWeightBottomRight = double.parse(value).toInt();
//           //     value = _queryEnteredWeightBottomRight.toString();
//           //     // _queryEnteredWeight2 = int.parse(value);
//           //     onSubmittedWeight2(value);

//           //     ///
//           //     /// Sync-up index value that used when button is pressed in single view mode.
//           //     ///
//           //     _ironMasterBottomViewWeightIndex = _getIronMasterWeightIndex(
//           //         context, _queryEnteredWeightBottomRight);
//           //     // onSubmittedWeight(_barbell2, value);
//           //   }
//           // },

//           ///
//           /// Show the header inside the dialog
//           ///
//           hideHeader: false,
//           initialFactionValue: 0,
//           userSpecified5lbPlateWeight:
//               Provider.of<WeightRackBlocNotifier>(context, listen: false)
//                   .weightCorrectionValue,
//         ).showDialog(context);

//         break;

//       default:
//         break;
//     }
//   }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // void _displayTopLeftIronMasterPicker() {
  //   switch (Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //       .dumbbellSet) {
  //     case 0:
  //       gShowIronMaster45LbSetPickerArray(
  //         context,
  //         title: (bRotateIronMasterView == true)
  //             ? "Left Dumbbell"
  //             : "Top Dumbbell",
  //         initialWholeValue:
  //         gIronMaster45LbWeightIndexFromPicker2(
  //             _queryEnteredWeightTopLeft,
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue),
  //         // gIronMaster45LbWeightIndexFromPicker(
  //         //     _queryEnteredWeight), // Index 0 equal 5lb
  //         // onConfirm: (NewNumberPicker picker) {
  //         //   String value = picker.getSelectedValues()[0];
  //         //   if (value != null) {
  //         //     // _queryEnteredWeight = int.parse(value);
  //         //     ///
  //         //     /// IRON MASTER - Apply User 5lb plate correction weight.
  //         //     /// _queryEnteredWeight2 is an int-type, and
  //         //     /// onSubmittedWeight2() requires an int-type string.
  //         //     ///
  //         //     _queryEnteredWeightTopLeft = double.parse(value).toInt();
  //         //     value = _queryEnteredWeightTopLeft.toString();
  //         //     onSubmittedWeight(value);

  //         //     ///
  //         //     /// Sync-up index value that used when button is pressed.
  //         //     ///
  //         //     _ironMasterTopViewWeightIndex = _getIronMasterWeightIndex(
  //         //         context, _queryEnteredWeightTopLeft);
  //         //   }
  //         // },

  //         ///
  //         /// Show the header inside the dialog
  //         ///
  //         hideHeader: false,
  //         initialFactionValue: 0,
  //         userSpecified5lbPlateWeight:
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue,
  //       ).showDialog(context);

  //       break;
  //     case 1:
  //       gShowIronMaster75LbSetPickerArray(
  //         context,
  //         title: (bRotateIronMasterView == true)
  //             ? "Left Dumbbell"
  //             : "Top Dumbbell",
  //         initialWholeValue: gIronMaster75LbWeightIndexFromPicker2(
  //             _queryEnteredWeightTopLeft,
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue),
  //         // gIronMaster75LbWeightIndexFromPicker(
  //         //     _queryEnteredWeight), // Index 0 equal 5lb
  //         // onConfirm: (NewNumberPicker picker) {
  //         //   String value = picker.getSelectedValues()[0];
  //         //   if (value != null) {
  //         //     // _queryEnteredWeight = int.parse(value);
  //         //     ///
  //         //     /// IRON MASTER - Apply User 5lb plate correction weight.
  //         //     /// _queryEnteredWeight2 is an int-type, and
  //         //     /// onSubmittedWeight2() requires an int-type string.
  //         //     ///
  //         //     _queryEnteredWeightTopLeft = double.parse(value).toInt();
  //         //     value = _queryEnteredWeightTopLeft.toString();
  //         //     onSubmittedWeight(value);

  //         //     ///
  //         //     /// Sync-up index value that used when button is pressed.
  //         //     ///
  //         //     _ironMasterTopViewWeightIndex = _getIronMasterWeightIndex(
  //         //         context, _queryEnteredWeightTopLeft);
  //         //   }
  //         // },

  //         ///
  //         /// Show the header inside the dialog
  //         ///
  //         hideHeader: false,
  //         initialFactionValue: 0,
  //         userSpecified5lbPlateWeight:
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue,
  //       ).showDialog(context);

  //       break;

  //     case 2:
  //       gShowIronMaster120LbSetPickerArray(
  //         context,
  //         title: (bRotateIronMasterView == true)
  //             ? "Left Dumbbell"
  //             : "Top Dumbbell",
  //         initialWholeValue: gIronMaster120LbWeightIndexFromPicker2(
  //             _queryEnteredWeightTopLeft,
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue), // Index 0 equal 5lb
  //         // onConfirm: (NewNumberPicker picker) {
  //         //   String value = picker.getSelectedValues()[0];
  //         //   if (value != null) {
  //         //     // _queryEnteredWeight = int.parse(value);
  //         //     ///
  //         //     /// IRON MASTER - Apply User 5lb plate correction weight.
  //         //     /// _queryEnteredWeight2 is an int-type, and
  //         //     /// onSubmittedWeight2() requires an int-type string.
  //         //     ///
  //         //     _queryEnteredWeightTopLeft = double.parse(value).toInt();
  //         //     value = _queryEnteredWeightTopLeft.toString();
  //         //     onSubmittedWeight(value);

  //         //     ///
  //         //     /// Sync-up index value that used when button is pressed.
  //         //     ///
  //         //     _ironMasterTopViewWeightIndex = _getIronMasterWeightIndex(
  //         //         context, _queryEnteredWeightTopLeft);
  //         //   }
  //         // },

  //         ///
  //         /// Show the header inside the dialog
  //         ///
  //         hideHeader: false,
  //         initialFactionValue: 0,
  //         userSpecified5lbPlateWeight:
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue,
  //       ).showDialog(context);

  //       break;
  //     case 3:
  //       gShowIronMaster165LbSetPickerArray(
  //         context,
  //         title: (bRotateIronMasterView == true)
  //             ? "Left Dumbbell"
  //             : "Top Dumbbell",
  //         initialWholeValue: gIronMaster165LbWeightIndexFromPicker2(
  //             context,
  //             _queryEnteredWeightTopLeft,
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue), // Index 0 equal 5lb
  //         // onConfirm: (NewNumberPicker picker) {
  //         //   String value = picker.getSelectedValues()[0];
  //         //   if (value != null) {
  //         //     // _queryEnteredWeight = int.parse(value);
  //         //     ///
  //         //     /// IRON MASTER - Apply User 5lb plate correction weight.
  //         //     /// _queryEnteredWeight2 is an int-type, and
  //         //     /// onSubmittedWeight2() requires an int-type string.
  //         //     ///
  //         //     _queryEnteredWeightTopLeft = double.parse(value).toInt();
  //         //     value = _queryEnteredWeightTopLeft.toString();
  //         //     onSubmittedWeight(value);

  //         //     ///
  //         //     /// Sync-up index value that used when button is pressed.
  //         //     ///
  //         //     _ironMasterTopViewWeightIndex = _getIronMasterWeightIndex(
  //         //         context, _queryEnteredWeightTopLeft);
  //         //   }
  //         // },

  //         ///
  //         /// Show the header inside the dialog
  //         ///
  //         hideHeader: false,
  //         initialFactionValue: 0,
  //         userSpecified5lbPlateWeight:
  //             Provider.of<WeightRackBlocNotifier>(context, listen: false)
  //                 .weightCorrectionValue,
  //       ).showDialog(context);

  //       break;
  //     default:
  //       break;
  //   }
  // }

  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///   Function:
  // ///
  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // String _gGetDumbbellSetString(int index) {
  //   switch (index) {
  //     case 0:
  //       return "45lb Dumbbell Set";
  //     case 1:
  //       return "75lb Dumbbell Set";
  //     case 2:
  //       return "120lb Dumbbell Set";
  //     case 3:
  //       return "165lb Dumbbell Set";
  //     default:
  //       return "45lb Dumbbell Set";
  //   }
  // }

  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///   Function:
  // ///
  // /////////////////////////////////////////////////////////////////////////////////////////////////
  // int _gGetDumbbellSetIndex(String name) {
  //   switch (name) {
  //     case "45lb Set":
  //       return 0;
  //     case "75lb Set":
  //       return 1;
  //     case "120lb Set":
  //       return 2;
  //     case "165lb Set":
  //       return 3;
  //     default:
  //       return 0;
  //   }
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function: _createCircularIconButton()
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // Widget _createCircularIconButton(IconData iconData) {
  //   return Material(
  //     color: Colors.transparent,
  //     child: Ink(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.indigoAccent, width: 4.0),
  //         color: Colors.grey, //.amber[900], //indigo[900],
  //         shape: BoxShape.circle,
  //       ),
  //       child: InkWell(
  //         //This keeps the splash effect within the circle
  //         borderRadius:
  //             BorderRadius.circular(150.0), //Something large to ensure a circle
  //         // onTap: _messages,
  //         child: Padding(
  //           padding: const EdgeInsets.all(2.0),
  //           child: Icon(
  //             iconData, //Icons.arrow_forward, //arrow_right,
  //             size: 24,
  //             color: Theme.of(context).primaryColor, //Colors.black,
  //           ), //Icon(Icons.rotate_right),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function: build()
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // double _currentValue = 4.0;

    final mediaQuery = MediaQuery.of(context);
    // final child = KeyedSubtree(key: barbellStateKey, child: _barbell);
    final CommonSwitchClass metricSwitch = Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).kiloPoundsSelectionSwitch;

    // JG Note:
    // WillPopScope encapsulates the entire Widgets tree,
    // and listens to the "Back Button" being pressed.
    // return

    final blocPrefs = Provider.of<PreferenceProvider>(context).bloc;
    return StreamBuilder<Object>(
        stream: blocPrefs.brightness,
        builder: (context, snapshotBrightness) {
          // if (!snapshotBrightness.hasData) {
          //   return Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           colors: [Color(0xFF485563), Color(0xFF29323C)],
          //           tileMode: TileMode.clamp,
          //           begin: Alignment.topCenter,
          //           stops: [0.0, 1.0],
          //           end: Alignment.bottomCenter),
          //     ),
          //   );
          // }
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (snapshotBrightness.data == Brightness.light)
                      ? [Color(0xFFaaaaaa), Color(0xFFeeeeee)]
                      : [Color(0xFF485563), Color(0xFF29323C)],
                  tileMode: TileMode.clamp,
                  begin: Alignment.topCenter,
                  stops: [0.0, 1.0],
                  end: Alignment.bottomCenter),
            ),
            child: Scaffold(
              // key: _scaffoldKey, // For Picker
              // backgroundColor: Colors.transparent,
              ///
              /// JG 1/14/2023 -
              ///   Modified original app_bar.dart Flutter code to fix extraneous height in title area:
              ///
              ///     /Users/jamesgros/development/tools/flutter/packages/flutter/lib/src/material/app_bar.dart
              ///     NOTE:  Moved the Align widget to If/Else statement when AppBar.flexibleSpace is null.
              ///
              ///   Without this fix, an extra Align widget was instantiated that was showing up
              ///   as the extraneous space in the title bar area for ** iOS target only **.
              ///
              appBar: AppBar(
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       Navigator.push(context, NumberInputPage.route());
                //     },
                //     icon: const Icon(
                //       CupertinoIcons.settings,
                //     ),
                //   ),
                // ],
                toolbarHeight: 80,
                // automaticallyImplyLeading: false,
                // leading: Text("LEADING YO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"),
                primary: ((Platform.isIOS))
                    ? true
                    : false, // For iOS, setting to 'false' removed the "Listener" object 47pixel at top of AppBar
                // toolbarHeight: 60,

                title: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Provider.of<WeightRackBlocNotifier>(context, listen: true)
                              .isIronMasterDumbbellSet
                          ? Column(
                              children: [
                                Text("IRON MASTER"),
                                Text("DUMBBELL"),
                              ],
                            )
                          : Text(
                              "MOJEER DUMBBELL",
                              // textScaleFactor:
                              //     (mediaQuery.size.width <= 640) ? 0.75 : 1.0,
                              style: TextStyle(
                                color: (snapshotBrightness.data ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      // Image.asset(
                      //   "lib/features/ironmaster_dumbbells/assets/icons/main_logo.png",
                      //   width: 60,
                      //   height: 60,
                      // ),
                      // Text(
                      //   " DUMBBELL",
                      //   // textScaleFactor:
                      //   //     (mediaQuery.size.width <= 640) ? 0.75 : 1.0,
                      //   style: TextStyle(
                      //     color: (snapshotBrightness.data == Brightness.light)
                      //         ? Colors.black
                      //         : Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                backgroundColor: Colors.deepPurpleAccent,
                flexibleSpace: Container(
                  height:
                      80 + (((Platform.isIOS) == true) ? kToolbarHeight : 0.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: (snapshotBrightness.data == Brightness.light)
                            ? [Color(0xFFaaaaaa), Color(0xFFeeeeee)]
                            : [Color(0xFF485563), Color(0xFF29323C)],
                        // [Color(0xFF485563), Color(0xFF29323C)],
                        tileMode: TileMode.clamp,
                        begin: Alignment.topCenter,
                        stops: [0.0, 1.0],
                        end: Alignment.bottomCenter),
                  ),
                ),
                centerTitle: true,
              ),

              // resizeToAvoidBottomInset: false,
              body: Container(
                height: (mediaQuery.size.height -
                        mediaQuery.padding.top -
                        kToolbarHeight) *
                    // (mediaQuery.size.height - mediaQuery.padding.top - kToolbarHeight) *
                    1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: (snapshotBrightness.data == Brightness.light)
                          ? [Color(0xFFaaaaaa), Color(0xFFeeeeee)]
                          : [Color(0xFF485563), Color(0xFF29323C)],
                      // [Color(0xFF485563), Color(0xFF29323C)],
                      tileMode: TileMode.clamp,
                      begin: Alignment.topCenter,
                      stops: [0.0, 1.0],
                      end: Alignment.bottomCenter),
                ),
                // padding: EdgeInsets.all(0.0),
                child: BlocListener<WeightrackBloc, WeightrackState>(
                  listener: (context, state) {
                    if (state is WeightrackError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(state.message),
                      //   ),
                      // );
                    }
                  },
                  child: BlocBuilder<WeightrackBloc, WeightrackState>(
                    builder: (context, state) {
                      if (state is WeightrackInitial) {
                        // // Immediately trigger the event
                        // BlocProvider.of<WeightrackBloc>(context)
                        //     .add(WeightrackInitializePlate(
                        //         context,
                        //         _queryEnteredWeightTopLeft, //_queryEnteredWeightBottomRight,
                        //         _oneRepMax,
                        //         _percent,
                        //         _barbell,
                        //         // true indicates Top/Left dumbbell
                        //         true));
                        // BlocProvider.of<WeightrackBloc>(context)
                        //     .add(WeightrackInitializePlate(
                        //         context,
                        //         _queryEnteredWeightBottomRight, //_queryEnteredWeightTopLeft,
                        //         _oneRepMax,
                        //         _percent,
                        //         _barbell2,
                        //         // false indicates Bottom/Right dumbbell
                        //         false));
                      }

                      return Stack(
                        // alignment: AlignmentDirectional.center,
                        children: [
                          ///
                          /// FIXED Positioned widget
                          ///
                          // Positioned(
                          //   left: 0,
                          //   right: 0,
                          //   top: 0,
                          //   bottom: mediaQuery.size.height -
                          //       mediaQuery.padding.top -
                          //       kToolbarHeight -
                          //       64,
                          //   child: Center(
                          //     // heightFactor: mediaQuery.size.height / 2,
                          //     // widthFactor: mediaQuery.size.width / 2,
                          //     child: Text(
                          //       gGetDumbbellSetString(
                          //         Provider.of<WeightRackBlocNotifier>(context,
                          //                 listen: true)
                          //             .dumbbellSet,
                          //       ),
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         // fontStyle: FontStyle.italic,
                          //         fontWeight: FontWeight.bold,
                          //         color: (snapshotBrightness.data ==
                          //                 Brightness.light)
                          //             ? Colors.black
                          //             : Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            bottom: (mediaQuery.size.height -
                                    mediaQuery.padding.top -
                                    kToolbarHeight) *
                                .12,
                            child: (_barbell2.myStateInstance != null)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: _barbell2
                                        .myStateInstance.platesUsedDetail,
                                  )
                                : Text(
                                    "_barbell2.myStateInstance is NULL!",
                                    style: TextStyle(
                                        color: Color.fromARGB(0, 210, 53, 53)),
                                  ),
                            //Container(),
                          ),

                          ///
                          /// FIXED Positioned  Settings Widget
                          ///

                          // Positioned(
                          //   bottom: 10,
                          //   left: 10,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       Navigator.push(context, SettingsPage.route());
                          //     },
                          //     icon: const Icon(
                          //       CupertinoIcons.settings,
                          //     ),
                          //   ),
                          // ),

                          // ///
                          // /// FIXED Positioned widget
                          // ///
                          // Positioned(
                          //   bottom: 200,
                          //   right: 20,
                          //   child: GestureDetector(
                          //       onTap: () async {
                          //         setState(() {
                          //           bRotateIronMasterView =
                          //               !bRotateIronMasterView;

                          //           if (bRotateIronMasterView == true) {
                          //             _rotateDumbbellAnimController.forward();
                          //             _rotateWeightTextAnimController.forward();
                          //           } else {
                          //             _rotateDumbbellAnimController.reverse();
                          //             _rotateWeightTextAnimController.reverse();
                          //           }
                          //         });

                          //         /// manage the state of each value

                          //         // RotateIronMasterView = !gRotateIronMasterView;

                          //         Provider.of<WeightRackBlocNotifier>(context,
                          //                     listen: false)
                          //                 .isRotatedViewMode =
                          //             bRotateIronMasterView;
                          //       },
                          //       child: (bRotateIronMasterView)
                          //           ? Icon(Icons.rotate_right_sharp,
                          //               color: (snapshotBrightness.data ==
                          //                       Brightness.light)
                          //                   ? Colors.black
                          //                   : Colors.white,
                          //               size: 72)
                          //           : Icon(Icons.rotate_left_sharp,
                          //               color: (snapshotBrightness.data ==
                          //                       Brightness.light)
                          //                   ? Colors.black
                          //                   : Colors.white,
                          //               size: 72)),
                          // ),

                          CustomScrollView(
                            // key: barbellStateKey,
                            shrinkWrap: true,
                            slivers: <Widget>[
                              SliverList(
                                ///
                                /// Special Information:
                                ///   Using a SliverChildListDelegate works better with the popup
                                ///   keyboard when entering desired weight.
                                ///
                                delegate: SliverChildListDelegate(
                                  [
                                    // (kDebugMode)
                                    //     ?
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 4.0,
                                          bottom:
                                              mediaQuery.size.height * .180),
                                      child: SizedBox(
                                        height: 60,
                                      ),
                                    ),
                                    // :
                                    // Padding(
                                    //     padding: EdgeInsets.only(
                                    //         top: 4.0,
                                    //         bottom: mediaQuery.size.height *
                                    //             .180),
                                    //     child:
                                    // Column(
                                    //   children: [
                                    //     Text(
                                    //       gGetDumbbellSetString(
                                    //         Provider.of<WeightRackBlocNotifier>(
                                    //                 context,
                                    //                 listen: true)
                                    //             .dumbbellSet,
                                    //       ),
                                    //       // style: TextStyle(
                                    //       //   fontSize: 16,
                                    //       //   color: Colors.orangeAccent,
                                    //       // ),
                                    //       style: TextStyle(
                                    //           color: Theme.of(context)
                                    //               .textSelectionTheme
                                    //               .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                    //           fontSize: 16.0,
                                    //           fontWeight:
                                    //               FontWeight.bold),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 60,
                                    //       child: MultiSelectContainer(
                                    //           maxSelectableCount: 1,
                                    //           singleSelectedItem: true,
                                    //           isMaxSelectableWithPerpetualSelects:
                                    //               true,
                                    //           showInListView: true,
                                    //           listViewSettings:
                                    //               ListViewSettings(
                                    //                   scrollDirection:
                                    //                       Axis
                                    //                           .horizontal,
                                    //                   separatorBuilder: (_,
                                    //                           __) =>
                                    //                       const SizedBox(
                                    //                         width: 10,
                                    //                       )),
                                    //           items: [
                                    //             MultiSelectCard(
                                    //                 value: '45lb Set',
                                    //                 label: '45lb Set'),
                                    //             MultiSelectCard(
                                    //                 value: '75lb Set',
                                    //                 label: '75lb Set'),
                                    //             MultiSelectCard(
                                    //                 value: '120lb Set',
                                    //                 label: '120lb Set'),
                                    //             MultiSelectCard(
                                    //                 value: '165lb Set',
                                    //                 label: '165lb Set'),
                                    //           ],
                                    //           onChange:
                                    //               (allSelectedItems,
                                    //                   selectedItem) {
                                    //             if (kDebugMode) {
                                    //               print(
                                    //                   'selectedItem = $selectedItem');
                                    //             }
                                    //             Provider.of<WeightRackBlocNotifier>(
                                    //                         context,
                                    //                         listen: false)
                                    //                     .dumbbellSet =
                                    //                 gGetDumbbellSetIndex(
                                    //                     selectedItem);

                                    //             // Set maxes
                                    //             gIronMasterWeightMaxIndex =
                                    //                 gGetIronMasterDumbbellSetMaxIndex(
                                    //                     context);
                                    //             Provider.of<
                                    //                     WeightRackBlocNotifier>(
                                    //               context,
                                    //               listen: false,
                                    //             ).ironMasterBottomViewWeightIndex =
                                    //                 gIronMasterWeightMaxIndex -
                                    //                     1;

                                    //             gIronMasterBottomViewWeightIndex =
                                    //                 gIronMasterWeightMaxIndex -
                                    //                     1;
                                    //           }),
                                    //     )
                                    //   ],
                                    // ),
                                    // ),

                                    ///
                                    /// Test Animation of Rotate/Translate - END
                                    ///

                                    RotationTransition(
                                      turns: Tween(begin: 0.0, end: -0.25)
                                          // turns: Tween(begin: 0.0, end: 1.0)
                                          .animate(
                                              _rotateDumbbellAnimController),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width +
                                                20,
                                        height:
                                            gDumbbellContainerAreaHeight + 20,
                                        child:

                                            ///
                                            /// Barbell View Bottom/Right
                                            ///
                                            Column(
                                          children: [
                                            _buildWeightPlate(
                                                _barbell2,
                                                _queryEnteredWeightBottomRight
                                                    .toDouble()),

                                            ///
                                            /// Display Weight Text
                                            ///
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.center,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.center,
                                            //   children: [
                                            //     RotationTransition(
                                            //       turns: Tween(
                                            //               begin: 0.0, end: 0.25)
                                            //           // turns: Tween(begin: 0.0, end: 1.0)
                                            //           .animate(
                                            //               _rotateWeightTextAnimController),
                                            //       child: Text(
                                            //         Provider.of<WeightRackBlocNotifier>(
                                            //                 context,
                                            //                 listen: false)
                                            //             .totalPlatesWeight
                                            //             .floor()
                                            //             .toString(),
                                            //         style: TextStyle(
                                            //             color: Theme.of(context)
                                            //                 .textSelectionTheme
                                            //                 .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                            //             fontSize: 14.0,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       ),
                                            //     ),
                                            //     RotationTransition(
                                            //       turns: Tween(
                                            //               begin: 0.0, end: 0.25)
                                            //           // turns: Tween(begin: 0.0, end: 1.0)
                                            //           .animate(
                                            //               _rotateWeightTextAnimController),
                                            //       child: Text(
                                            //         ((metricSwitch.isSwitchedOn ==
                                            //                     false) ||
                                            //                 Provider.of<WeightRackBlocNotifier>(
                                            //                             context,
                                            //                             listen:
                                            //                                 false)
                                            //                         .dumbbellSet ==
                                            //                     4)
                                            //             ? "kg"
                                            //             : "lb",
                                            //         style: TextStyle(
                                            //             color: Theme.of(context)
                                            //                 .textSelectionTheme
                                            //                 .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                            //             fontSize: 14.0,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // ///
                                    // /// Row or Column widget containing Left/Right Arrows
                                    // ///
                                    // (Provider.of<WeightRackBlocNotifier>(
                                    //                     context,
                                    //                     listen: true)
                                    //                 .isDumbbellSingleView ==
                                    //             false &&
                                    //         _barbell.myStateInstance != null &&
                                    //         Provider.of<BarbellDisplayListBlocNotifier>(
                                    //                 context,
                                    //                 listen: true)
                                    //             .changedPlates)
                                    //     ? Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceEvenly,
                                    //         children: _barbell.myStateInstance
                                    //             .platesUsedDetail,
                                    //       )
                                    //     : Text(
                                    //         "Failed to display Left/Right Arrows",
                                    //         style: TextStyle(
                                    //             color: Color.fromARGB(
                                    //                 0, 210, 53, 53)),
                                    //       ),

                                    // Padding(
                                    //   padding: const EdgeInsets.fromLTRB(
                                    //       24, 128, 24, 24),
                                    // Use FittedBox to children to scale down to fit inside the available space
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 115, 24, 24),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              iconSize: 36,
                                              icon: Icon(Icons.arrow_back_ios),
                                              color: Colors.blueAccent,
                                              onPressed: () async {
                                                // Check and update Bottom or Right side dumbbells
                                                if (gIronMasterBottomViewWeightIndex >
                                                    0) {
                                                  gIronMasterBottomViewWeightIndex--;
                                                  Provider.of<
                                                          WeightRackBlocNotifier>(
                                                    context,
                                                    listen: false,
                                                  ).ironMasterBottomViewWeightIndex =
                                                      gIronMasterBottomViewWeightIndex;
                                                }
                                              },
                                            ),
                                            Container(
                                              // width: MediaQuery.of(context).size.width,
                                              width: mediaQuery.size.width * .6,
                                              decoration: BoxDecoration(
                                                ///
                                                /// Add a border color around the plate to make it
                                                /// more visible when plates are stacked next to each
                                                /// other on the barbell.
                                                ///
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      169, 113, 66, 1.0),
                                                ),
                                                // color: Colors.cyan),
                                                color: Colors.transparent,
                                              ),
                                              // color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeight).floor()}",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),

                                                  Text(
                                                    ((metricSwitch.isSwitchedOn ==
                                                                false) ||
                                                            Provider.of<WeightRackBlocNotifier>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isMoJeerDumbbellSet ==
                                                                true)
                                                        ? "kg"
                                                        : "lb",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ((metricSwitch.isSwitchedOn ==
                                                                false) ||
                                                            Provider.of<WeightRackBlocNotifier>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isMoJeerDumbbellSet ==
                                                                true)
                                                        ? " (${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeightLbs).floor()}lbs)"
                                                        : " (${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeightKg).floor()}kg)",

                                                    ///
                                                    /// Dont show the kg equivalent when in lb mode for Iron Master dumbbells
                                                    /// Because the Row() area overflows with flutter error.
                                                    ///
                                                    // : " (${(Provider.of<WeightRackBlocNotifier>(context, listen: false).totalPlatesWeightKg).floor()}kg)",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),

                                                  /// Add Padding when 22.5lb plates are used
                                                  ((Provider.of<
                                                                  WeightRackBlocNotifier>(
                                                            context,
                                                            listen: false,
                                                          ))
                                                              .usesTwentyTwoLbPlates &&
                                                          (Provider.of<
                                                                      WeightRackBlocNotifier>(
                                                                context,
                                                                listen: false,
                                                              )
                                                                  .show22lbPlatesCheckboxAndGraphics ==
                                                              true))
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 24))
                                                      : Container(),

                                                  /// Add Checkbox Widget when 22.5lb plates are used.
                                                  ((Provider.of<
                                                              WeightRackBlocNotifier>(
                                                            context,
                                                            listen: false,
                                                          )).usesTwentyTwoLbPlates &&
                                                          (Provider.of<WeightRackBlocNotifier>(
                                                                context,
                                                                listen: false,
                                                              ).show22lbPlatesCheckboxAndGraphics ==
                                                              true))
                                                      ? SizedBox(
                                                          height: 36,
                                                          child:
                                                              // (isTopLeftDumbbell == true)
                                                              //     ? _displayTopLeftUse22lbCheckbox(context)
                                                              //     :
                                                              _displayBottomRightUse22lbCheckbox(
                                                            context,
                                                          ),
                                                        )
                                                      : Container(),

                                                  /// Display the 22.5lb rectangle widget
                                                  ((Provider.of<
                                                              WeightRackBlocNotifier>(
                                                            context,
                                                            listen: false,
                                                          )).usesTwentyTwoLbPlates &&
                                                          (Provider.of<WeightRackBlocNotifier>(
                                                                context,
                                                                listen: false,
                                                              ).show22lbPlatesCheckboxAndGraphics ==
                                                              true))
                                                      ? Stack(
                                                          children: [
                                                            Positioned(
                                                              child: Container(
                                                                // foregroundDecoration: StrikeThroughDecoration(),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  ///
                                                                  /// Add a border color around the plate to make it
                                                                  /// more visible when plates are stacked next to each
                                                                  /// other on the barbell.
                                                                  ///
                                                                  border: Border
                                                                      .all(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            169,
                                                                            113,
                                                                            66,
                                                                            1.0),
                                                                  ),
                                                                  // color: Colors.cyan),
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .10, //MediaQuery.of(context).size.width * .05,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .05, // MediaQuery.of(context).size.height * .10,
                                                                child: Text(
                                                                  "22.5",
                                                                  // textScaleFactor: 0.75,
                                                                  textScaler:
                                                                      TextScaler
                                                                          .noScaling, // .linear(1),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  // textDirection: TextDirection.LTR,
                                                                  style:
                                                                      DefaultTextStyle
                                                                              .of(
                                                                    context,
                                                                  ).style.apply(
                                                                            fontSizeFactor:
                                                                                0.75,
                                                                            // (widget.widthPlate * 0.75) / widget.widthPlate,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                  // textWidthBasis: TextWidthBasis.longestLine,
                                                                ),
                                                              ),
                                                            ),
                                                            (Provider.of<
                                                                            WeightRackBlocNotifier>(
                                                                      context,
                                                                      listen:
                                                                          false,
                                                                    )
                                                                        .showStrickthroughOn22lbPlate ==
                                                                    true)
                                                                ? Positioned(
                                                                    child:
                                                                        Container())
                                                                : Positioned(
                                                                    // left: ((MediaQuery.of(context).size.height * .10) -
                                                                    //         24) /
                                                                    //     2,
                                                                    // top: 2,
                                                                    child:
                                                                        Container(
                                                                      foregroundDecoration:
                                                                          StrikeThroughDecoration(),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          .10, //MediaQuery.of(context).size.width * .05,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .05, // MediaQuery.of(context).size.height * .10,
                                                                    ),
                                                                    // const Icon(
                                                                    //   Icons.not_interested,
                                                                    //   size: 16.0,
                                                                    //   color: Colors.deepOrangeAccent,
                                                                    // ),
                                                                  ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 36,
                                              icon:
                                                  Icon(Icons.arrow_forward_ios),
                                              color: Colors.blueAccent,
                                              onPressed: () {
                                                // Check and update Bottom or Right side dumbbells
                                                if (gIronMasterBottomViewWeightIndex <
                                                    gIronMasterWeightMaxIndex) {
                                                  gIronMasterBottomViewWeightIndex++;

                                                  Provider.of<
                                                          WeightRackBlocNotifier>(
                                                    context,
                                                    listen: false,
                                                  ).ironMasterBottomViewWeightIndex =
                                                      gIronMasterBottomViewWeightIndex;
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    ///
                                    /// FIXED Positioned widget
                                    ///
                                    GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            bRotateIronMasterView =
                                                !bRotateIronMasterView;

                                            if (bRotateIronMasterView == true) {
                                              _rotateDumbbellAnimController
                                                  .forward();
                                              _rotateWeightTextAnimController
                                                  .forward();
                                            } else {
                                              _rotateDumbbellAnimController
                                                  .reverse();
                                              _rotateWeightTextAnimController
                                                  .reverse();
                                            }
                                          });

                                          /// manage the state of each value

                                          // RotateIronMasterView = !gRotateIronMasterView;

                                          Provider.of<WeightRackBlocNotifier>(
                                                      context,
                                                      listen: false)
                                                  .isRotatedViewMode =
                                              bRotateIronMasterView;
                                        },
                                        child: (bRotateIronMasterView)
                                            ? Icon(Icons.rotate_right_sharp,
                                                color:
                                                    (snapshotBrightness.data ==
                                                            Brightness.light)
                                                        ? Colors.black
                                                        : Colors.white,
                                                size: 36)
                                            : Icon(Icons.rotate_left_sharp,
                                                color:
                                                    (snapshotBrightness.data ==
                                                            Brightness.light)
                                                        ? Colors.black
                                                        : Colors.white,
                                                size: 36)),
                                    ///////////////
                                    ///
                                    ///
                                    ///
                                    _dumbbellSetChangedCallbackFunction(
                                        context),

                                    _weightCorrectionValueChangedCallbackFunction(
                                        context),

                                    // _useTopLeft22lbCheckboxChangedCallbackFunction(
                                    //     context),

                                    _useBottomRight22lbCheckboxChangedCallbackFunction(
                                        context),

                                    (Provider.of<WeightRackBlocNotifier>(
                                                    context,
                                                    listen: true)
                                                .ironMasterBottomViewWeightIndex !=
                                            _ironMasterBottomViewWeightIndex)
                                        ? _useBottomLeftRightButtonPressedCallbackFunction(
                                            context)
                                        : Container(),

                                    ///////////////
                                    ///
                                    ///
                                    ///

                                    // Divider(
                                    //   color: Colors.deepOrangeAccent,
                                    // ),

                                    ///
                                    /// IRON MASTER - Use the Nested Plates and Enter Weight Query for DEBUG.
                                    ///
                                    // (Provider.of<BarbellDisplayListBlocNotifier>(context,
                                    //                 listen: true)
                                    //             .changedPlates ==
                                    //         true)
                                    //     ? testNestedScrollbar(_barbell)
                                    //     : (Container()),

                                    // Divider(
                                    //   color: Colors.deepOrangeAccent,
                                    // ),

                                    ///////////////
                                    ///
                                    ///
                                    ///
                                    // _displayQueryEnterWeight(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
    // ,
    // ); // WillPopScope
  }
}
