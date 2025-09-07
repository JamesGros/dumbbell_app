import 'dart:convert';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/loadbarbell_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/loadbarbell_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/commonswitch.dart';
import 'package:flutter/material.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';

import 'package:provider/provider.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/preference_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';

///
/// Callback type for use by this class and loadbarbell_view.dart class
///
typedef DumbbellChangedCallbackType = void Function(int index);

class DumbbellSetCheckboxList extends StatefulWidget {
  const DumbbellSetCheckboxList({super.key});

  @override
  State<DumbbellSetCheckboxList> createState() =>
      _DumbbellSetCheckboxListState();
}

// bool _useHeavy22lbPlatesTopLeft = true;
// bool _useHeavy22lbPlatesBottRight = true;

class _DumbbellSetCheckboxListState extends State<DumbbellSetCheckboxList> {
  Brightness _brightness = Brightness.light;
  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": (gSharedPrefs.dumbbellSetChoice ==
          0), // Temporary Default during development
      "title": "45lb IronMaster Set",
    },
    {
      "id": 1,
      "value": (gSharedPrefs.dumbbellSetChoice == 1), //false, // Default
      "title": "75lb IronMaster Set",
    },
    {
      "id": 2,
      "value": (gSharedPrefs.dumbbellSetChoice == 2), //false,
      "title": "120lb IronMaster Set",
    },
    {
      "id": 3,
      "value": (gSharedPrefs.dumbbellSetChoice ==
          3), //false, //true, // Temporary Default during development
      "title": "165lb IronMaster Set",
    },
    {
      "id": 4,
      "value": (gSharedPrefs.dumbbellSetChoice ==
          4), //false, //true, // Temporary Default during development
      "title": "MoJeer 20kg Set",
    },
    {
      "id": 5,
      "value": (gSharedPrefs.dumbbellSetChoice ==
          5), //false, //true, // Temporary Default during development
      "title": "MoJeer 40kg Set",
    },
  ];

  double _fiveLbWeight = 5.0;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  _weighed5lbPlateValueWidget
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _weighed5lbPlateValueWidget(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final CommonSwitchClass metricSwitch =
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .kiloPoundsSelectionSwitch;
    return Column(
      children: [
        Text(
          "Weighed 5lb Plate",
          style: TextStyle(
              // color: Colors
              //     .white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold),
        ),
        Row(
          // alignment: Alignment.center,
          // mainAxisAlignment:
          //     (Provider.of<WeightRackBlocNotifier>(context, listen: false)
          //                 .dumbbellSet >=
          //             2)
          //         ? MainAxisAlignment.spaceBetween //.end
          //         : MainAxisAlignment.center,
          children: <Widget>[
            ///
            /// Left Arrow Button
            ///
            IconButton(
                // iconSize: 36,
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.blueAccent,
                // onPressed: () {
                onPressed: () async {
                  // Check and update Top or Left side dumbbells
                  setState(() {
                    if (_fiveLbWeight > 4.4) {
                      _fiveLbWeight -= 0.1;
                    }

                    _fiveLbWeight =
                        double.parse(_fiveLbWeight.toStringAsFixed(1));
                  });

                  Provider.of<WeightRackBlocNotifier>(context, listen: false)
                      .weightCorrectionValue = _fiveLbWeight;

                  gSharedPrefs.weighed5LbPlate = _fiveLbWeight;
                  gSharedPrefs.changeWeighed5lbPlate(_fiveLbWeight);
                }),

            /// Display the totalPlatesWeight value
            Container(
              // width: MediaQuery.of(context).size.width,
              width: mediaQuery.size.width * .3,
              decoration: BoxDecoration(
                ///
                /// Add a border color around the plate to make it
                /// more visible when plates are stacked next to each
                /// other on the barbell.
                ///
                border: Border.all(
                    color: (_brightness == Brightness.dark)
                        ? Colors.orangeAccent
                        : Colors.black),
              ), //Color.fromRGBO(169, 113, 66, 1.0)),
              // color: Colors.cyan),
              // color: Colors.transparent),
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _fiveLbWeight.toString(),
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (metricSwitch.isSwitchedOn == false) ? "kg" : "lb",
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            ///
            /// Right Arrow Button
            ///
            IconButton(
                // iconSize: 36,
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    // Check and update Top or Left side dumbbells
                    if (_fiveLbWeight < 5.0) {
                      _fiveLbWeight += 0.1;
                    }

                    // _5LbWeight = _5LbWeight - _5LbWeight.truncate();
                    _fiveLbWeight =
                        double.parse(_fiveLbWeight.toStringAsFixed(1));
                  });

                  Provider.of<WeightRackBlocNotifier>(context, listen: false)
                      .weightCorrectionValue = _fiveLbWeight;

                  gSharedPrefs.weighed5LbPlate = _fiveLbWeight;
                  gSharedPrefs.changeWeighed5lbPlate(_fiveLbWeight);
                }),
            // IconButton(icon: Icon(Icons.arrow_right_outlined), onPressed: () {}),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fiveLbWeight = gSharedPrefs.weighed5LbPlate;

    // gSharedPrefs.dumbbellSetChoice = 1;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PreferenceProvider>(context).bloc;
    final mediaQuery = MediaQuery.of(context);
    // top = number of DB Set seclection items above it (4) * height of each item (64).
    final double offsetToEndOfCheckboxList = mediaQuery.size.height * .45;
    // checkListItems.length * 16.0;
    final double heightOfWeighedButton =
        (mediaQuery.size.height - mediaQuery.padding.top - kToolbarHeight) *
            .125;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 40.0, bottom: 0.0),
        // padding: const EdgeInsets.only(left: 15, top: 40.0, bottom: 0.0),
        // padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: List.generate(
                checkListItems.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (_brightness == Brightness.dark)
                                ? Colors.orangeAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // height: 50,
                      child: CheckboxListTile(
                        // selected:
                        //     (gIronMasterBottomViewWeightIndex - 1) == index,
                        // selectedTileColor: Colors.amber,
                        // activeColor: Colors.amber,
                        // secondary: const Icon(
                        //   Icons.settings,
                        //   color: Colors.deepOrangeAccent,
                        // ),
                        // secondary: Image.asset("assets/ironmaster.png"),
                        secondary: Image.asset(
                          "lib/features/ironmaster_dumbbells/assets/icons/main_logo.png",
                          width: 36,
                          height: 36,
                        ),
                        autofocus: true,
                        controlAffinity: ListTileControlAffinity.platform,
                        // activeColor: Colors.green,
                        // checkColor: Colors.white,
                        // controlAffinity: ListTileControlAffinity.leading,
                        // contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          checkListItems[index]["title"],
                          style: const TextStyle(
                            // backgroundColor: Colors.amber,
                            fontSize: 16.0,
                            // color: Colors.white,
                          ),
                        ),
                        value: (gSharedPrefs.dumbbellSetChoice == index)
                            ? true
                            : false, //checkListItems[index]["value"],
                        onChanged: (value) {
                          if (Provider.of<WeightRackBlocNotifier>(context,
                                      listen: false)
                                  .dumbbellSet !=
                              index) {
                            setState(() {
                              for (var element in checkListItems) {
                                element["value"] = false;
                              }
                              checkListItems[index]["value"] = value;
                              selected =
                                  "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";

                              ///
                              /// Set barbell in use
                              ///
                              if (index == 4 || index == 5) {
                                Provider.of<LoadBarbellBlocNotifier>(
                                  context,
                                  listen: false,
                                ).barbellInUse = BarbellType.BARBELL_MOJEER_4kg;
                              } else {
                                Provider.of<LoadBarbellBlocNotifier>(
                                  context,
                                  listen: false,
                                ).barbellInUse =
                                    BarbellType.BARBELL_IRONMASTER_5lb;
                              }

                              ///
                              /// Set index of dumbbell set in use
                              ///
                              Provider.of<WeightRackBlocNotifier>(context,
                                      listen: false)
                                  .dumbbellSet = index;

                              ///
                              /// Save to preferences
                              ///
                              gSharedPrefs.dumbbellSetChoice = index;
                              gSharedPrefs.changeIronMasterDumbbellSet(index);

                              ///
                              /// This is the 5lb weight correction value for the IronMaster dumbbell handle + locking screws.
                              /// Not used by MoJeer dumbbell set
                              _fiveLbWeight = gSharedPrefs.weighed5LbPlate;

                              // Set to max selectable weight index
                              gIronMasterWeightMaxIndex =
                                  gGetDumbbellSetMaxIndex(context);
                              Provider.of<WeightRackBlocNotifier>(
                                context,
                                listen: false,
                              ).ironMasterBottomViewWeightIndex =
                                  gIronMasterWeightMaxIndex;

                              gIronMasterBottomViewWeightIndex =
                                  gIronMasterWeightMaxIndex;
                              // // Set to max selectable weight index
                              // gIronMasterBottomViewWeightIndex =
                              //     gIronMasterWeightMaxIndex;

                              // Reset to zero - JG 9/1
                              // Provider.of<WeightRackBlocNotifier>(context,
                              //         listen: false)
                              //     .desiredWeight = 0.0;
                            });
                          }
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4)),
                  ],
                ),
              ),
            ),

            ///
            ///
            /// TODO:  Note - Updated explorer_widget.dart line 177 to adjust Setting area height.
            ///
            (Provider.of<WeightRackBlocNotifier>(
                      context,
                      listen: false,
                    ).isIronMasterDumbbellSet ==
                    true)
                ? Positioned(
                    // top = number of DB Set seclection items above it (4) * height of each item (64).
                    top:
                        offsetToEndOfCheckboxList, //mediaQuery.size.height * .25,
                    child: _weighed5lbPlateValueWidget(context),
                  )
                : Container(),

            ///
            /// Brand Mode
            ///
            // Positioned(
            //   // top = number of DB Set seclection items above it (4) * height of each item (64).
            //   top: offsetToEndOfCheckboxList + heightOfWeighedButton - 16,
            //   child: Row(
            //     mainAxisAlignment:
            //         MainAxisAlignment.center, // MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         'Dumbbell Brand',
            //         // style: TextStyle(color: Colors.white),
            //       ),
            //       StreamBuilder<bool>(
            //           stream: bloc.dumbbellMetricInPoundsStreamed,
            //           builder: (context, snapshot) {
            //             if (!snapshot.hasData) return Container();
            //             return Switch(
            //               value: (snapshot.data == false) ? false : true,
            //               // inactiveTrackColor: Colors.black54,
            //               // activeTrackColor: Colors.black54,
            //               // activeColor: Colors.black54,
            //               onChanged: (bool value) {
            //                 if (value) {
            //                   bloc.changeDumbbellMetricInPounds(true);
            //                 } else {
            //                   bloc.changeDumbbellMetricInPounds(false);
            //                 }
            //               },
            //             );
            //           }),
            //       StreamBuilder<bool>(
            //           stream: bloc.dumbbellMetricInPoundsStreamed,
            //           builder: (context, snapshot) {
            //             if (!snapshot.hasData) return Container();
            //             return Text(
            //               (snapshot.data == true)
            //                   ? "Iron Master DB"
            //                   : "MoJeer DB",
            //               // style: TextStyle(color: Colors.white),
            //             );
            //           }),
            //     ],
            //   ),
            //   // commonSwitch(
            //   //     context,
            //   //     Provider.of<WeightRackBlocNotifier>(context, listen: false)
            //   //         .kiloPoundsSelectionSwitch),
            // ),

            ///
            /// View Mode
            ///
            Positioned(
              // top = number of DB Set seclection items above it (4) * height of each item (64).
              top: offsetToEndOfCheckboxList + heightOfWeighedButton + 64 - 16,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'View Mode',
                    // style: TextStyle(color: Colors.white),
                  ),
                  StreamBuilder<Brightness>(
                      stream: bloc.brightness,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return Switch(
                          value: (snapshot.data == Brightness.light)
                              ? false
                              : true,
                          // inactiveTrackColor: Colors.black54,
                          // activeTrackColor: Colors.black54,
                          // activeColor: Colors.black54,
                          onChanged: (bool value) {
                            if (value) {
                              bloc.changeBrightness(Brightness.dark);
                              _brightness = Brightness.dark;
                            } else {
                              bloc.changeBrightness(Brightness.light);
                              _brightness = Brightness.light;
                            }
                          },
                        );
                      }),
                  StreamBuilder<Brightness>(
                      stream: bloc.brightness,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return Text(
                          (snapshot.data == Brightness.light)
                              ? "Light"
                              : "Dark",
                          // style: TextStyle(color: Colors.white),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
