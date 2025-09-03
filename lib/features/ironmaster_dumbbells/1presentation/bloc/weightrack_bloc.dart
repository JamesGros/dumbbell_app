import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/bloc/preference_bloc.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/barbelldisplaylist_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/loadbarbell_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/calculate_weight_onbarbell.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/utils/ironmaster_dbell_set.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/menu_notifier.dart';
// import 'package:dumbbell_app/models/alert_request.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/commonSwitch_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/loadbarbell_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/weightplate_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/widgets/animated_barbell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'weightrack_event.dart';
part 'weightrack_state.dart';

class StrikeThroughDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _StrikeThroughPainter();
  }
}

class _StrikeThroughPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = new Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // JG Size? theSize = configuration.size;
    final rect = offset & configuration.size!;
    // canvas.drawLine(new Offset(rect.left, rect.top + rect.height / 2),
    //     new Offset(rect.right, rect.top + rect.height / 2), paint);
    canvas.drawLine(
      new Offset(rect.left, rect.top),
      new Offset(rect.right, rect.bottom),
      paint,
    );

    ///
    /// IRON MASTER -
    ///   The canvas.restore() call disrupts the Flutter widget tree
    ///   versus element tree rendering logic when the 2 dunbbells
    ///   are rotated from loadbarbell_view.dart page.
    ///   I.e., The bottom/right dumbbell does not Rotate 90 degrees!
    ///
    // canvas.restore();
  }
}

class MyKeys {
  static final myCheckboxKey1 = const Key('__MYCHECKBOXKEY1__');
  static final myCheckboxKey2 = const Key('__MYCHECKBOXKEY2__');
}

/////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Function:
///
/////////////////////////////////////////////////////////////////////////////////////////////////
Checkbox _displayTopLeftUse22lbCheckbox(BuildContext context) {
  return Checkbox(
    // key: UniqueKey(),
    // key: barbellStateKey,
    // key: MyKeys.myCheckboxKey1,

    // autofocus: true,
    activeColor: Colors.green,
    checkColor: Colors.white,
    focusColor: Colors.orangeAccent,
    // overlayColor: Colors.orangeAccent,
    value: Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).useHeavy22lbPlatesTopLeft,
    onChanged: (bool? value) {
      Provider.of<WeightRackBlocNotifier>(context, listen: false)
          .useHeavy22lbPlatesTopLeft = value!;
    },
  );
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

class WeightrackBloc extends Bloc<WeightrackEvent, WeightrackState> {
  WeightrackBloc() : super(WeightrackInitial()) {
    // on<WeightrackEvent>((event, emit) => emit(WeightrackInitial()));
    // on<WeightrackEvent>((event, emit) => emit(WeightrackLoading()));
    on<WeightrackInitializePlate>(_initializePlateState);
    on<WeightrackChangeBarbell>(_weightrackChangeBarbellState);
    on<WeightrackUpdatePlate>(_weightrackUpdatePlateState);
    on<WeightrackAddPlate>(_weightrackAddPlateState);
    on<WeightrackRemovePlate>(_weightrackRemovePlateState);
    on<WeightrackAnimatePlate>(_weightrackAnimatePlateState);

    // on<WeightrackEvent>((event, emit) => emit(WeightrackError()));
  }

  // @override
  WeightrackState get initialState => WeightrackInitial();

  void _weightrackAnimatePlateState(
      WeightrackAnimatePlate event, Emitter<WeightrackState> emit) {
    {
      ///
      /// Get the selected weight rack
      ///
      List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
        event._context,
      );

      ///
      /// Animate plate state handler
      ///
      _updatePlatesOnBarbell(
        event._queryEnteredWeight.toDouble(),
        event._context,
        event._animatedBarbell.myStateInstance, //event._animatedBarbell,
        theRack,
        false,
      );

      ///
      /// The "yield" is commented out, because we are using Notifiers to update the Widget Tree.
      ///
      // yield WeightrackLoaded(_getSelectedWeightRackList(event._context));
      // yield WeightrackLoading();
    }
  }

  void _weightrackRemovePlateState(
      WeightrackRemovePlate event, Emitter<WeightrackState> emit) {
    {
      // Update Weight
      AnimatedPlate lastAnimatedPlate =
          Provider.of<BarbellDisplayListBlocNotifier>(
        event._context,
        listen: false,
      ).lastAnimatedPlateItem;

      ///
      /// Get the selected weight rack
      ///
      List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
        event._context,
      );

      for (WeightPlatesItemClass item in theRack) {
        if (lastAnimatedPlate.realWeight == item.weight && item.usedCount > 0) {
          // double temp = event._queryEnteredWeight.toDouble();
          // temp -= (item.weight * 2); // x2 for both sides of barbell.
          // event._queryEnteredWeight = temp.toInt();

          item.usedCount -= 1;
          item.plateRemoved = true;

          ///
          /// Update the Provider to notify that usedCount has changed.
          ///
          _setSelectedWeightRackList(event._context, theRack);

          /// Notify the AnimatedBarbell class that outer plates are being added.
          /// Triggers the plates animation on the barbell.
          Provider.of<BarbellDisplayListBlocNotifier>(
            event._context,
            listen: false,
          ).removeOuterPlates = true;

          // Provider.of<BarbellDisplayListBlocNotifier>(
          //   event._context,
          //   listen: false,
          // ).lastAnimatedPlateItem = null;

          Provider.of<BarbellDisplayListBlocNotifier>(
            event._context,
            listen: false,
          ).changedPlates = true;
        }
      }

      ///
      /// Animate plate state handler
      ///
      _updatePlatesOnBarbell(
        event._queryEnteredWeight.toDouble(),
        event._context,
        event._animatedBarbell.myStateInstance,
        theRack,
        false,
      );

      ///
      /// Scale the barbell if the plates reached the end of barbell
      ///
      /// Positioned positionedWidget = Provider.of<BarbellDisplayListBlocNotifier>(
      ///
      List<Widget> displayList = Provider.of<BarbellDisplayListBlocNotifier>(
        event._context,
        listen: false,
      ).displayList;

      /// When the displayList only contains the barbell with no plates loaded,
      /// the displayList list has a length of 1 of type Container Widget.
      ///
      /// i.e. Container Widget inside it 2 Childeren widgets,
      ///      the Positioned Widgets for Left and Right Collar.
      ///
      if (displayList.length > 1) {
        Positioned positionedWidget = displayList.last as Positioned;

        if (positionedWidget.left! >
            MediaQuery.of(event._context).size.width * .90) {
          if (event._animatedBarbell.myStateInstance.scale < 1.0) {
            event._animatedBarbell.myStateInstance.scale += .05;
            event._animatedBarbell.myStateInstance.barbellProperty
                .widthBarbell -= 40;
          }
        }
      }

      ///
      /// The "yield" is commented out, because we are using Notifiers to update the Widget Tree.
      ///
      // yield WeightrackLoaded(_getSelectedWeightRackList(event._context));
      // yield WeightrackLoading();
    }
  }

  void _weightrackAddPlateState(
      WeightrackAddPlate event, Emitter<WeightrackState> emit) {
    {
      // Update Weight
      if (event._plateItem.ownIt == true &&
          event._plateItem.usedCount < event._plateItem.numOwned / 2) {
        // double temp = event._queryEnteredWeight.toDouble();
        // temp += (event._plateItem.weight * 2); // x2 for both sides of barbell.
        // event._queryEnteredWeight = temp.toInt();

        event._plateItem.usedCount +=
            1; // TBD:  This is updated when the _platesList is updated in AenimatedBarbell class
        event._plateItem.plateAdded = true;

        ///
        /// Get the selected weight rack
        ///
        List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
          event._context,
        );

        ///
        /// Updated the Provider to notify that usedCount has changed.
        ///
        _setSelectedWeightRackList(event._context, theRack);

        /// Notify the AnimatedBarbell class that outer plates are being added.
        /// Triggers the plates animation on the barbell.
        Provider.of<BarbellDisplayListBlocNotifier>(
          event._context,
          listen: false,
        ).addOuterPlates = true;

        ///
        /// Animate plate state handler
        ///
        _updatePlatesOnBarbell(
          0.0,
          event._context,
          event._animatedBarbell.myStateInstance,
          theRack,
          false,
        );

        ///
        /// Scale the barbell if the plates reached the end of barbell
        ///
        Positioned positionedWidget =
            Provider.of<BarbellDisplayListBlocNotifier>(
          event._context,
          listen: false,
        ).displayList.last as Positioned;
        //event._animatedBarbell.myStateInstance.displayList.last;
        if (positionedWidget.left! >
            MediaQuery.of(event._context).size.width * .90) {
          if (event._animatedBarbell.myStateInstance.scale >= .5) {
            event._animatedBarbell.myStateInstance.scale -= .05;
            event._animatedBarbell.myStateInstance.barbellProperty
                .widthBarbell += 100;
            // widget.barbellProperty.widthBarbell
          }
        }
      }

      ///
      /// The "yield" is commented out, because we are using Notifiers to update the Widget Tree.
      ///
      // yield WeightrackLoading();

      ///
      /// EVENT:  WeightrackRemovePlate
      /// The desired weight was updated by the user when adding or removing plates.
      /// The barbell's weight (i.e. via picker) WAS NOT changed.
      ///
    }
  }

  void _weightrackUpdatePlateState(
      WeightrackUpdatePlate event, Emitter<WeightrackState> emit) {
    {
      // print('event is $event');

      event._animatedBarbell.myStateInstance.barbellProperty.desiredWeight =
          event._queryEnteredWeight.toDouble();

      ///
      /// _resetRackPlatesUsedCountAndBarbellDisplayList is DEPRECATED.
      ///
      // _resetRackPlatesUsedCountAndBarbellDisplayList(event._context);

      ///
      /// Get the selected weight rack
      ///
      List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
        event._context,
      );

      // CommonSwitchClass metricSwitch =
      //     Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
      //         .kiloPoundsSelectionSwitch;

      // Query the BarbellBlocNotifier provider for which barbell is selected.
      BarbellType barbellInUse = Provider.of<LoadBarbellBlocNotifier>(
        event._context,
        listen: false,
      ).barbellInUse;
      double barbellWeight = getCurrentBarbellTypeDouble(barbellInUse);

      // Determine the weight to load on the barbell.
      // TODO: TBD - Load this from Firebase database.
      // double desiredWeight = 315.0;
      double desiredWeight =

          ///  ????????????????????????
          event._queryEnteredWeight
              .toDouble(); //event._oneRepMax * event._percent;

      // Update shared preference on device - desired weight.
      gSharedPrefs.desiredWeight = desiredWeight;
      gSharedPrefs.changeDesiredWeight(desiredWeight);

      // Update desired and actual weight used on barbell.
      // double calculatedWeight =

      ///
      /// Clear the used counts before the rack structure is used
      /// to calculate the number of plates loaded on the barbell
      /// given the desired weight.
      ///
      // if (Provider.of<ScrollPercentBlocNotifier>(event._context, listen: false)
      //         .wendlerSetTypeMenu
      //         .isWarmupOn ==
      //     false) {
      for (var index = 0; index < theRack.length; index++) {
        theRack[index].usedCount = 0;
      }
      // }

      ///
      /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
      ///
      if (Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).isIronMasterDumbbellSet &&
          Provider.of<WeightRackBlocNotifier>(
                event._context,
                listen: false,
              ).dumbbellSet >=
              2) {
        theRack[1].ownIt =
            true; // index 1 is 22.5lb plate by design used by default
        if (event._topLeftDumbbell == false &&
            Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).useHeavy22lbPlatesBottomRight ==
                false) {
          theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
        } else if (event._topLeftDumbbell == true &&
            Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).useHeavy22lbPlatesTopLeft ==
                false) {
          theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
        }
      }

      if (Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).isIronMasterDumbbellSet ==
          true) {
        ///`
        /// IRON MASTER - Apply User 5lb plate correction weight.
        ///
        if (Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).dumbbellSet >=
            2) {
          ///
          /// Index 2 is mapped to 5lb plate by design in weightrack_notifier.dart
          /// for 120lb Iron Master Quick-Lock Set.
          ///
          theRack[2].weight = Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).weightCorrectionValue;
        } else {
          ///
          /// Index 1 is mapped to 5lb plate by design in weightrack_notifier.dart
          ///
          theRack[1].weight = Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).weightCorrectionValue;
        }
      }

      ///
      /// The desired weight was updated by the user when desired weight is
      /// submitted from "Enter Weight (lb)" input field.
      /// The barbell's weight (i.e. via picker) WAS NOT changed.
      ///
      double calculatedWeight = calculateWeightSet(
        theRack,
        desiredWeight,
        barbellWeight,
      );
      Provider.of<BarbellDisplayListBlocNotifier>(event._context, listen: false)
          .changedPlates = true;

      if (Provider.of<WeightRackBlocNotifier>(
        event._context,
        listen: false,
      ).isIronMasterDumbbellSet) {
        ///
        /// IF the calculated weight is less than threshold (e.g. +/- 5 lbs),
        /// then make an adjustment.   The threshold +/- 5lb should be specified by
        /// the user of the App.
        /// If the desiredWeight is zero, then bypass the threshold check, because
        /// then only the barbell weight is the calculated weight!
        ///
        const double userThreshold = 5.0;
        const double threshold = userThreshold / 2;
        if (desiredWeight > 0 && calculatedWeight != desiredWeight) {
          ///
          /// Determine if NOT within threshold
          ///
          if ((calculatedWeight - desiredWeight).abs() > threshold) {
            ///
            /// Calculate a new target weight to get closer to desired weight
            /// within the threshold.
            ///
            double newTargetWeight = calculatedWeight + userThreshold;

            ///
            /// Clear the used counts before the rack structure is used
            /// to calculate the number of plates loaded on the barbell
            /// given the desired weight.
            ///
            for (var index = 0; index < theRack.length; index++) {
              theRack[index].usedCount = 0;
            }

            ///
            /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
            ///
            if (Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).isIronMasterDumbbellSet &&
                Provider.of<WeightRackBlocNotifier>(
                      event._context,
                      listen: false,
                    ).dumbbellSet >=
                    2) {
              theRack[1].ownIt =
                  true; // index 1 is 22.5lb plate by design used by default
              if (event._topLeftDumbbell == false &&
                  Provider.of<WeightRackBlocNotifier>(
                        event._context,
                        listen: false,
                      ).useHeavy22lbPlatesBottomRight ==
                      false) {
                theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
              } else if (event._topLeftDumbbell == true &&
                  Provider.of<WeightRackBlocNotifier>(
                        event._context,
                        listen: false,
                      ).useHeavy22lbPlatesTopLeft ==
                      false) {
                theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
              }
            }
            if (Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).isIronMasterDumbbellSet) {
              ///
              /// IRON MASTER - Apply User 5lb plate correction weight.
              ///
              if (Provider.of<WeightRackBlocNotifier>(
                    event._context,
                    listen: false,
                  ).dumbbellSet >=
                  2) {
                ///
                /// Index 2 is mapped to 5lb plate by design in weightrack_notifier.dart
                /// for 120lb Iron Master Quick-Lock Set.
                ///
                theRack[2].weight = Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).weightCorrectionValue;
              } else {
                ///
                /// Index 1 is mapped to 5lb plate by design in weightrack_notifier.dart
                ///
                theRack[1].weight = Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).weightCorrectionValue;
              }
            }

            calculatedWeight = calculateWeightSet(
              theRack,
              newTargetWeight,
              barbellWeight,
            );
          }
        }
      } else {
        calculatedWeight = calculateWeightSet(
          theRack,
          desiredWeight,
          barbellWeight,
        );
      }

      ///
      /// Animate plate state handler
      ///
      _updatePlatesOnBarbell(
        event._queryEnteredWeight.toDouble(),
        event._context,
        event._animatedBarbell.myStateInstance,
        theRack,
        event._topLeftDumbbell,
      );
      ////////////

      ///
      /// The "yield" is commented out, because we are using Notifiers to update the Widget Tree.
      ///
      // yield WeightrackInitial();
      // yield WeightrackLoading();
    }
  }

  void _weightrackChangeBarbellState(
      WeightrackChangeBarbell event, Emitter<WeightrackState> emit) {
    ///
    /// _resetRackPlatesUsedCountAndBarbellDisplayList is DEPRECATED.
    ///
    // _resetRackPlatesUsedCountAndBarbellDisplayList(event._context);

    ///
    /// Get the selected weight rack
    ///
    List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
      event._context,
    );

    // CommonSwitchClass metricSwitch =
    //     Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
    //         .kiloPoundsSelectionSwitch;

    // Query the BarbellBlocNotifier provider for which barbell is selected.
    BarbellType barbellInUse = Provider.of<LoadBarbellBlocNotifier>(
      event._context,
      listen: false,
    ).barbellInUse;
    double barbellWeight = getCurrentBarbellTypeDouble(barbellInUse);

    // Determine the weight to load on the barbell.
    // TODO: TBD - Load this from Firebase database.
    // double desiredWeight = 315.0;
    ///
    /// The desiredWeight can come from WendlerView, HatchView, or
    /// LoadBarbellView.
    ///
    double desiredWeight =

        ///  ????????????????????????
        event._queryEnteredWeight
            .toDouble(); //event._oneRepMax * event._percent;

    // Update desired and actual weight used on barbell.
    // double calculatedWeight =
    ///
    /// Clear the used counts before the rack structure is used
    /// to calculate the number of plates loaded on the barbell
    /// given the desired weight.
    ///
    // if (Provider.of<ScrollPercentBlocNotifier>(event._context,
    //             listen: false)
    //         .wendlerSetTypeMenu
    //         .isWarmupOn ==
    //     false) {
    for (var index = 0; index < theRack.length; index++) {
      theRack[index].usedCount = 0;
    }

    ///
    /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
    //// index 1 is 22.5lb plate by design
    if (Provider.of<WeightRackBlocNotifier>(
          event._context,
          listen: false,
        ).isIronMasterDumbbellSet &&
        Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).dumbbellSet >=
            2) {
      theRack[1].ownIt =
          true; // index 1 is 22.5lb plate by design used by default
      if (event._topLeftDumbbell == false &&
          Provider.of<WeightRackBlocNotifier>(
                event._context,
                listen: false,
              ).useHeavy22lbPlatesBottomRight ==
              false) {
        theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
      } else if (event._topLeftDumbbell == true &&
          Provider.of<WeightRackBlocNotifier>(
                event._context,
                listen: false,
              ).useHeavy22lbPlatesTopLeft ==
              false) {
        theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
      }
    }

    if (Provider.of<WeightRackBlocNotifier>(
          event._context,
          listen: false,
        ).isIronMasterDumbbellSet ==
        true) {
      ///
      /// IRON MASTER - Apply User 5lb plate correction weight.
      ///
      if (Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).dumbbellSet >=
          2) {
        ///
        /// Index 2 is mapped to 5lb plate by design in weightrack_notifier.dart
        /// for 120lb Iron Master Quick-Lock Set.
        ///
        theRack[2].weight = Provider.of<WeightRackBlocNotifier>(
          event._context,
          listen: false,
        ).weightCorrectionValue;
      } else {
        ///
        /// Index 1 is mapped to 5lb plate by design in weightrack_notifier.dart
        ///
        theRack[1].weight = Provider.of<WeightRackBlocNotifier>(
          event._context,
          listen: false,
        ).weightCorrectionValue;
      }
    }

    double calculatedWeight = calculateWeightSet(
      theRack,
      desiredWeight,
      barbellWeight,
    );
    Provider.of<BarbellDisplayListBlocNotifier>(
      event._context,
      listen: false,
    ).changedPlates = true;

    ///
    /// IF the calculated weight is less than threshold (e.g. +/- 5 lbs),
    /// then make an adjustment.   The threshold +/- 5lb should be specified by
    /// the user of the App.
    /// If the desiredWeight is zero, then bypass the threshold check, because
    /// then only the barbell weight is the calculated weight!
    ///
    const double userThreshold = 5.0;
    const double threshold = userThreshold / 2;
    if (desiredWeight > 0 && calculatedWeight != desiredWeight) {
      ///
      /// Determine if NOT within threshold
      ///
      if ((calculatedWeight - desiredWeight).abs() > threshold) {
        ///
        /// Calculate a new target weight to get closer to desired weight
        /// within the threshold.
        ///
        double newTargetWeight = calculatedWeight + userThreshold;

        ///
        /// Clear the used counts before the rack structure is used
        /// to calculate the number of plates loaded on the barbell
        /// given the desired weight.
        ///
        for (var index = 0; index < theRack.length; index++) {
          theRack[index].usedCount = 0;
        }

        ///
        /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
        ///
        if (Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).isIronMasterDumbbellSet &&
            Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).dumbbellSet >=
                2) {
          theRack[1].ownIt =
              true; // index 1 is 22.5lb plate by design used by default
          if (event._topLeftDumbbell == false &&
              Provider.of<WeightRackBlocNotifier>(
                    event._context,
                    listen: false,
                  ).useHeavy22lbPlatesBottomRight ==
                  false) {
            theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
          } else if (event._topLeftDumbbell == true &&
              Provider.of<WeightRackBlocNotifier>(
                    event._context,
                    listen: false,
                  ).useHeavy22lbPlatesTopLeft ==
                  false) {
            theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
          }
        }

        if (Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).isIronMasterDumbbellSet ==
            true) {
          ///
          /// IRON MASTER - Apply User 5lb plate correction weight.
          ///
          if (Provider.of<WeightRackBlocNotifier>(
                event._context,
                listen: false,
              ).dumbbellSet >=
              2) {
            ///
            /// Index 2 is mapped to 5lb plate by design in weightrack_notifier.dart
            /// for 120lb Iron Master Quick-Lock Set.
            ///
            theRack[2].weight = Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).weightCorrectionValue;
          } else {
            ///
            /// Index 1 is mapped to 5lb plate by design in weightrack_notifier.dart
            ///
            theRack[1].weight = Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).weightCorrectionValue;
          }
        }

        calculatedWeight = calculateWeightSet(
          theRack,
          newTargetWeight,
          barbellWeight,
        );
      }
    }

    ///
    /// Update the Provider to notify that usedCount has changed.
    ///
    _setSelectedWeightRackList(event._context, theRack);

    // /// Notify the AnimatedBarbell class that outer plates are being added.
    // /// Triggers the plates animation on the barbell.
    // Provider.of<BarbellDisplayListBlocNotifier>(event._context,
    //         listen: false)
    //     .addOuterPlates = true;

    ///
    /// Animate plate state handler
    ///
    _updatePlatesOnBarbell(
      event._queryEnteredWeight.toDouble(),
      event._context,
      event._animatedBarbell.myStateInstance,
      theRack,
      event._topLeftDumbbell,
    );

    // JG 1/25/2025 - yield not need with emit() style event/state implementation
    // yield WeightrackLoading();

    ///
    /// EVENT:  WeightrackUpdatePlate
    /// The desired weight was updated by the user when desired weight is
    /// submitted from "Enter Weight (lb)" input field.
    /// The barbell's weight (i.e. via picker) WAS NOT changed.
    ///
  }

  void _initializePlateState(
      WeightrackInitializePlate event, Emitter<WeightrackState> emit) {
    if (kDebugMode) {
      print('event is $event');
    }

    ///
    /// If the users weight rack is empty, then alert the user.
    ///
    if (_doesWeightRackHaveEnough(event._context) == false) {
      _onAlertWeightRackInsufficient(event._context);
    }

    if (Provider.of<WeightRackBlocNotifier>(
          event._context,
          listen: false,
        ).isIronMasterDumbbellSet ==
        true) {
      Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
          .weightCorrectionValue = gSharedPrefs.weighed5LbPlate;
    }
    Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
        .dumbbellSet = gSharedPrefs.dumbbellSetChoice;

    // Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
    //     .weightCorrectionValue = gSharedPrefs.weighed5LbPlate;

    double desiredWeight = gSharedPrefs.desiredWeight;
    Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
        .desiredWeight = desiredWeight;

    event._animatedBarbell.myStateInstance.barbellProperty.desiredWeight =
        desiredWeight;

    ///
    /// MenuNotifier is not used for Iron Master App
    ///
    // if (Provider.of<MenuNotifier>(
    //       event._context,
    //       listen: false,
    //     ).statePreviousPage ==
    //     MainMeuWorkoutsEnum.LOADBAR) {
    //   ///
    //   /// Get the selected weight rack
    //   ///
    //   List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
    //     event._context,
    //   );

    //   ///
    //   /// Updated the Provider to notify that usedCount has changed.
    //   ///
    //   _setSelectedWeightRackList(event._context, theRack);

    //   /// Reset flags..
    //   Provider.of<BarbellDisplayListBlocNotifier>(
    //     event._context,
    //     listen: false,
    //   ).removeOuterPlates = false;
    //   Provider.of<BarbellDisplayListBlocNotifier>(
    //     event._context,
    //     listen: false,
    //   ).addOuterPlates = false;

    //   /// Special Information (07/09/2020):
    //   ///
    //   /// Set the BarbellDisplayListBlocNotifier.changedPlates here to true to notify
    //   /// the renderer to redraw the barbell as well as the plates details widgets.
    //   ///
    //   Provider.of<BarbellDisplayListBlocNotifier>(
    //     event._context,
    //     listen: false,
    //   ).changedPlates = true;
    // } else
    {
      ///
      /// Get the selected weight rack
      ///
      List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(
        event._context,
      );

      // CommonSwitchClass metricSwitch =
      //     Provider.of<WeightRackBlocNotifier>(event._context, listen: false)
      //         .kiloPoundsSelectionSwitch;

      // Query the BarbellBlocNotifier provider for which barbell is selected.
      BarbellType barbellInUse = Provider.of<LoadBarbellBlocNotifier>(
        event._context,
        listen: false,
      ).barbellInUse;
      double barbellWeight = getCurrentBarbellTypeDouble(barbellInUse);

      // // Determine if in Kilo metrics (false).
      // if (metricSwitch.isSwitchedOn == false) {
      //   // Convert Pounds to Kilo
      //   barbellWeight /= POUNDS2KILO_FACTOR;
      //   // desiredWeight /= POUNDS2KILO_FACTOR;
      // }

      // Determine the weight to load on the barbell.
      // double desiredWeight = 315.0;
      // double desiredWeight = event._oneRepMax * event._percent;

      // Update desired and actual weight used on barbell.
      // double calculatedWeight =

      ///
      /// Clear the used counts before the rack structure is used
      /// to calculate the number of plates loaded on the barbell
      /// given the desired weight.
      ///
      for (var index = 0; index < theRack.length; index++) {
        theRack[index].usedCount = 0;
      }

      ///
      /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
      ///
      if (Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).isIronMasterDumbbellSet &&
          Provider.of<WeightRackBlocNotifier>(
                event._context,
                listen: false,
              ).dumbbellSet >=
              2) {
        theRack[1].ownIt =
            true; // index 1 is 22.5lb plate by design used by default

        if (event._topLeftDumbbell == false &&
            Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).useHeavy22lbPlatesBottomRight ==
                false) {
          theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
        } else if (event._topLeftDumbbell == true &&
            Provider.of<WeightRackBlocNotifier>(
                  event._context,
                  listen: false,
                ).useHeavy22lbPlatesTopLeft ==
                false) {
          theRack[1].ownIt = false; // index 1 is 22.5lb plate by design
        }
      }

      if (Provider.of<WeightRackBlocNotifier>(
        event._context,
        listen: false,
      ).isIronMasterDumbbellSet) {
        ///
        /// IRON MASTER - Apply User 5lb plate correction weight.
        ///
        if (Provider.of<WeightRackBlocNotifier>(
              event._context,
              listen: false,
            ).dumbbellSet >=
            2) {
          ///
          /// Index 2 is mapped to 5lb plate by design in weightrack_notifier.dart
          /// for 120lb Iron Master Quick-Lock Set.
          ///
          theRack[2].weight = Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).weightCorrectionValue;
        } else {
          ///
          /// Index 1 is mapped to 5lb plate by design in weightrack_notifier.dart
          ///
          theRack[1].weight = Provider.of<WeightRackBlocNotifier>(
            event._context,
            listen: false,
          ).weightCorrectionValue;
        }
      }
      Provider.of<BarbellDisplayListBlocNotifier>(
        event._context,
        listen: false,
      ).changedPlates = true;

      ///
      /// Update the weight index for the bottom view.
      /// This ensures that the bottom view is updated with the correct weight index.
      /// when the App is reinitialized by the User.
      ///
      gIronMasterBottomViewWeightIndex =
          gGetIronMasterWeightIndex(event._context, desiredWeight.toInt());
      Provider.of<WeightRackBlocNotifier>(
        event._context,
        listen: false,
      ).ironMasterBottomViewWeightIndex = gIronMasterBottomViewWeightIndex;

      ///
      /// Update the Provider to notify that usedCount has changed.
      ///
      _setSelectedWeightRackList(event._context, theRack);

      ///
      /// Animate plate state handler
      ///
      _updatePlatesOnBarbell(
        // event._queryEnteredWeight.toDouble(),
        event._animatedBarbell.myStateInstance.barbellProperty.desiredWeight,
        event._context,
        event._animatedBarbell.myStateInstance,
        theRack,
        event._topLeftDumbbell,
      );
    }

    ///
    /// The "yield" is commented out, because we are using Notifiers to update the Widget Tree.
    ///
    // yield WeightrackInitial();

    // JG 1/25/2025 - yield not need with emit() style event/state implementation
    // yield WeightrackLoading();

    ///
    /// EVENT:  WeightrackChangeBarbell
    /// The desired weight was updated by the user when adding or removing plates.
    /// The barbell's weight WAS changed (i.e. via picker).
    ///
  }

  /// @override
  @override
  void onError(Object error, StackTrace stackTrace) {
    // Custom onError logic goes here

    // Always call super.onError with the current error and stackTrace
    super.onError(error, stackTrace);
  }

  ////////////////////////////////////////////////////////////////////////////////
  /// Function:  _onAlertWeightRackInsufficient
  /// Purpose:
  /// Parameters:
  /// Notes:
  ////////////////////////////////////////////////////////////////////////////////
  _onAlertWeightRackInsufficient(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(color: Colors.grey),
      ),
      titleStyle: TextStyle(color: Colors.red),
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: "Weight Rack Is Empty",
      desc: "Add and Enable plates in your rack!",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  bool _doesWeightRackHaveEnough(BuildContext context) {
    List<WeightPlatesItemClass> theRack = _getSelectedWeightRackList(context);

    ///
    /// Tally the weights.
    ///
    double totalWeight = 0;
    // List<WeightPlatesItemClass> theRackCopy = [];
    for (WeightPlatesItemClass weightPlate in theRack) {
      if (weightPlate.numOwned > 0) {
        totalWeight += weightPlate.weight;
      }
    }

    ///
    /// If the total weights available is less than selected barbell, then
    /// return false (TBD).
    ///
    /// Or simply, if total is non-zero then return true.
    ///
    return (totalWeight > 0);
  }

  void _updatePlatesOnBarbell(
    double queriedWeight,
    BuildContext context,
    AnimatedBarbellState animatedBarbell,
    List<WeightPlatesItemClass> theRack,
    bool isTopLeftDumbbell,
  ) {
    // final mediaQuery = MediaQuery.of(context);

    // Get the global display list.
    // List<Widget> _displayList =
    //     Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
    //         .displayList;
    List<Widget> displayList = Provider.of<BarbellDisplayListBlocNotifier>(
      context,
      listen: false,
    ).displayList2;

    displayList.clear();

    ///
    /// IRON MASTER
    ///
    double ironMasterHandleWidth =
        animatedBarbell.getBarbellProperty.widthBarbell * .14;

    double collarWidth = animatedBarbell.getBarbellProperty.widthBarbell * 0.01;

    // Query the BarbellBlocNotifier provider for which barbell is selected.
    BarbellType barbellInUse = Provider.of<LoadBarbellBlocNotifier>(
      context,
      listen: false,
    ).barbellInUse;
    double barbellWeight = getCurrentBarbellTypeDouble(barbellInUse);

    if (Provider.of<BarbellDisplayListBlocNotifier>(
              context,
              listen: false,
            ).addOuterPlates ==
            false &&
        Provider.of<BarbellDisplayListBlocNotifier>(
              context,
              listen: false,
            ).removeOuterPlates ==
            false) {
      // // Determine if in Kilo metrics (false).
      // if (metricSwitch.isSwitchedOn == false) {
      //   // Convert Pounds to Kilo
      //   barbellWeight /= POUNDS2KILO_FACTOR;
      //   // desiredWeight /= POUNDS2KILO_FACTOR;
      // }

      // Special Information:
      //   This _AnimatedBarbellState is invoked by the WeightRackBlocNotifier whenever the state change
      //   occurs in the WeightRackBloc, for example when the common switch is toggled
      //   from Custom to Standard weight rack.
      //
      // Recreate the barbell with plates when entering LoadBarbelView from WendlerView or HatchView pages,
      // or when the LoadBarbellView changes the barbell type or the rack(s) used (Custom and/or Standard rack).
      if ((displayList
              .isNotEmpty) // "!=0" indiates _barbell and plates are on the display list.
          ||
          (Provider.of<BarbellDisplayListBlocNotifier>(
                context,
                listen: false,
              ).changedPlates ==
              false)) {
        // No chnage to display.
        return; // theRack;
      }

      // Empty the list of plates.
      animatedBarbell.platesList.clear();

      ///
      /// IRON MASTER - If the weight is greater than or equal to 10lb,
      ///               then sort rack list so that the locking screws
      ///               are spawned last.
      ///
      List<WeightPlatesItemClass> theRackSorted = [];
      for (var index = 1; index < theRack.length; index++) {
        // Check for the locking screw, should be the 1st item.
        // if (theRack.name == "LockScrew2.5lb") {
        // Move the locking screw to the end of the list.
        theRackSorted.add(theRack.elementAt(index));
      }

      ///
      /// Make adjustments to rack based on queriedWeight and Users
      /// 5lb plate correction.
      ///

      ///
      /// Add the locking screws
      ///
      theRackSorted.add(theRack.first);
      // Instantiate the animated plates and save them into the _platesList list.
      // The list is iterated within the build() method to display the
      // animated plates.

      ///
      /// TODO - Create a spawnKiloPlates for MoJeer,
      ///        or refactor spawnPoundsPlates() to spawnPlates(dumbbellSetType) since they
      ///        share similar logic.
      ///
      if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
          .isIronMasterDumbbellSet) {
        animatedBarbell.spawnPoundsPlatesIronMaster(context, theRackSorted);
      } else {
        animatedBarbell.spawnKiloPlatesMoJeer(context, theRackSorted);
      }
      // animatedBarbell.spawnPoundsPlates(theRack);

      // if (metricSwitch.isSwitchedOn == true) {
      //   animatedBarbell.spawnPoundsPlates(theRack);
      // } else {
      //   animatedBarbell.spawnKilosPlates(theRack);
      // }
    } else {
      if (Provider.of<BarbellDisplayListBlocNotifier>(
            context,
            listen: false,
          ).addOuterPlates ==
          true) {
        // Add animated platesto the _platesList list.
        // The list is iterated within the build() method to display the
        // animated plates.

        ///
        /// Add the outer plates.
        ///
        if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .isIronMasterDumbbellSet) {
          animatedBarbell.addPoundsPlateIronMaster(theRack);
        } else {
          animatedBarbell.addKiloPlateMoJeer(theRack);
        }
        _setSelectedWeightRackList(context, theRack);

        // if (metricSwitch.isSwitchedOn == true) {
        //   ///
        //   /// Add the outer plates.
        //   ///
        //   animatedBarbell.addPoundsPlate(theRack);
        //   _setSelectedWeightRackList(context, theRack);
        // } else {
        //   ///
        //   /// Add the outer plates.
        //   ///
        //   animatedBarbell.addKilosPlate(theRack);
        //   _setSelectedWeightRackList(context, theRack);
        // }
      } else if (Provider.of<BarbellDisplayListBlocNotifier>(
            context,
            listen: false,
          ).removeOuterPlates ==
          true) {
        // Remove animated platesto the _platesList list.
        // The list is iterated within the build() method to display the
        // animated plates.

        ///
        /// Remove the outer plates.
        ///
        if (Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .isIronMasterDumbbellSet) {
          animatedBarbell.removePoundsPlateIronMaster(theRack);
        } else {
          animatedBarbell.removeKilosPlateMoJeer(theRack);
        }
        _setSelectedWeightRackList(context, theRack);

        // if (metricSwitch.isSwitchedOn == true) {
        //   ///
        //   /// Remove the outer plates.
        //   ///
        //   animatedBarbell.removePoundsPlate(theRack);
        //   _setSelectedWeightRackList(context, theRack);
        // } else {
        //   ///
        //   /// Remove the outer plates.
        //   ///
        //   animatedBarbell.removeKilosPlate(theRack);
        //   _setSelectedWeightRackList(context, theRack);
        // }
      }

      if (animatedBarbell.platesList.isNotEmpty) {
        /// Save the lastPlateIndex in the Provider, the loadbarbell view will use this
        /// to determine how to layout the plate updater widgtes plus/minus buttons.
        AnimatedPlate lastElement = animatedBarbell.platesList.last;

        int lastAnimatedPlateIndex = animatedBarbell.platesList.lastIndexOf(
          lastElement,
        );

        ///
        /// OutdifThis code below causes an error "setState() or markNeedsBuild() called during build."
        /// from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
        ///
        Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
            .lastAnimatedPlateIndex = lastAnimatedPlateIndex;

        ///
        /// This code below causes an error "setState() or markNeedsBuild() called during build."
        /// if called outside this Blocs business logic.
        /// from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
        ///
        Provider.of<BarbellDisplayListBlocNotifier>(
          context,
          listen: false,
        ).lastAnimatedPlateItem =
            animatedBarbell.platesList[lastAnimatedPlateIndex];
      } else {
        ///
        /// This code below causes an error "setState() or markNeedsBuild() called during build."
        ///           from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
        ///
        Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
            .lastAnimatedPlateIndex = 0;

        ///
        /// This code below causes an error "setState() or markNeedsBuild() called during build."
        /// from flutter framework.dart:3880 inside markNeedsBuild() function,
        /// if called outside this Blocs business logic.
        ///
        // Provider.of<BarbellDisplayListBlocNotifier>(
        //   context,
        //   listen: false,
        // ).lastAnimatedPlateItem = null; //_platesList[lastAnimatedPlateIndex];
      }

      ///
      /// This code below causes an error "setState() or markNeedsBuild() called during build."
      /// from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
      ///
      // Reset flags
      Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
          .addOuterPlates = false;

      ///
      /// This code below causes an error "setState() or markNeedsBuild() called during build."
      /// from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
      ///
      Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
          .removeOuterPlates = false;
    }

    double displayAreaHeight = gDumbbellDisplayAreaHeight;

    double collarHeight =
        // animatedBarbell.widget.barbellProperty.heightBarbell * 4;
        MediaQuery.of(context).size.height * .10;

    double collarTopOffset = ((displayAreaHeight - collarHeight) / 2) -
        (collarHeight * 0.06); // END OF - if animatedBarbell == null

// if (animatedBarbell.theBarbell == null)
// {}
    // Create the barbell widget with collars.
    animatedBarbell.theBarbell = Container(
      // // JG DEBUG - added box around barbell for positioning guide.
      decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
      width: animatedBarbell.barbellProperty.widthBarbell,
      // height: animatedBarbell.widget.barbellProperty.heightBarbell * 4,
      height: displayAreaHeight,

      child: Stack(
        children: [
          // Positioned(top: 0, left: 4, child: Text(barbellTypeStr)),
          Positioned(
            ///
            /// Uncomment this line to shift the barbell off screen to the left
            /// to allow plates (left collar sleeve) at the end of barbell to be visible.
            ///
            right:
                ((gDumbbellDisplayAreaWidth - ironMasterHandleWidth) / 2) - 1,
            // ironMasterHandleWidth * collarsMultiplyFactor, //1.54,
            // right: 20 + ironMasterHandleWidth * 1.2,
            // right: 20 + ironMasterHandleWidth + 22,
            // right: 100,
            // left: -100,
            // width: animatedBarbell.widget.barbellProperty.widthBarbell *
            //     .5,
            width: ironMasterHandleWidth,

            top: (displayAreaHeight -
                    animatedBarbell.barbellProperty.heightBarbell -
                    4) / // -4 for the width of outline on Handle,
                2, //(this.widget.heightBarbell*4 - widget.heightBarbell) / 2,
            // ================================== Center bar
            child: Container(
              ///
              /// Use the rotated collar image as the bar.
              ///
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(
                      "lib/features/ironmaster_dumbbells/assets/knurl-surface-small.jpg"),
                  // image: AssetImage(
                  //     "assets/Pngtree_shiny_metal_rotated_collar_size2.jpg"),
                  // fit: BoxFit
                  //     .fill, //.scaleDown, //.fitWidth, //.cover, // .fitWidth, //.cover,
                  fit: BoxFit.fill,
                ),
              ),
              width: ironMasterHandleWidth,
              height: animatedBarbell.barbellProperty.heightBarbell,
              // color: widget.color,
            ),

            //     CustomPaint(
            //   size: Size(1000, 20),
            //   painter: MyPainter(),
            // ),
          ),
        ],
      ),
    ); // END OF - if animatedBarbell == null

    // Create a new display list of [_barbell, _platesList[0], ..., _platesList[n]]
    // animatedBarbell.theBarbell = AnimatedBarbell(
    //     // ironMasterHandle: IronMasterHandleType.IRONMASTER_LEFT_HANDLE,
    //     );
    displayList.add(animatedBarbell.theBarbell);
    // displayList.add(animatedBarbell as Widget);
    //  List<Widget> _displayList = Provider.of<BarbellDisplayListBlocNotifier>(context).barbellDisplayList;
    //  int length = _displayList.length;
    //  print("DEBUG - _displayList length = $length ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    //  _displayList.add(_barbell);

    displayList.add(
      Positioned(
        // height: animatedBarbell.platesList[1].heightPlate,
        // top: ((displayAreaHeight -
        //             animatedBarbell.platesList[1].heightPlate) /
        //         2) -
        //     animatedBarbell.platesList[1].heightPlate * 0.06,
        // height: collarHeight,
        // top: ((displayAreaHeight - collarHeight) / 2) -
        //     collarHeight * 0.06,
        // +
        // 1, // +1 for the width of outline from BoxDecoration border of rendered Plates
        // from AnimatedPlate object.
        ///
        ///
        ///
        ///
        height: MediaQuery.of(context).size.height * .10,
        // top: ((displayAreaHeight -
        //             (MediaQuery.of(context).size.height * .10)) /
        //         2) -
        //     (MediaQuery.of(context).size.height * .10) * 0.06,
        top: collarTopOffset,
        // ((displayAreaHeight - (MediaQuery.of(context).size.height * .10)) /
        //         2) -
        //     ((MediaQuery.of(context).size.height * .10) * 0.06),

        // height: animatedBarbell.platesList[0].heightPlate,
        // top: ((displayAreaHeight -
        //             animatedBarbell.platesList[0].heightPlate) /
        //         2) -
        //     animatedBarbell.platesList[0].heightPlate * 0.06,
        //   top: ((displayAreaHeight -
        //         animatedBarbell.platesList[index].heightPlate) /
        //     2) -
        // animatedBarbell.platesList[index].heightPlate * 0.06,
        right: ((gDumbbellDisplayAreaWidth - ironMasterHandleWidth) / 2) -
            4, // -4 for the width of outline on Handle from BoxDecoration border
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            // color: Colors.red),
            color: animatedBarbell.barbellProperty.color,
            // color: animatedBarbell.widget.myStateInstance.barbellProperty.color,
          ),
          width: collarWidth,
          height: MediaQuery.of(context).size.height *
              .10, //collarHeight, // Collar is double the height of handle
          // color: widget.color,
        ),
      ),
    );
    // ==================================== Right collar
    displayList.add(
      Positioned(
        // height: animatedBarbell.platesList[1].heightPlate,
        // top: ((displayAreaHeight -
        //             animatedBarbell.platesList[1].heightPlate) /
        //         2) -
        //     animatedBarbell.platesList[1].heightPlate * 0.06,

        // height: collarHeight,
        // top: ((displayAreaHeight - collarHeight) / 2) -
        //     collarHeight * 0.06,
        // // from AnimatedPlate object.

        ///
        ///
        // height: MediaQuery.of(context).size.height * .10,
        // top: ((displayAreaHeight -
        //             (MediaQuery.of(context).size.height * .10)) /
        //         2) -
        //     ((MediaQuery.of(context).size.height * .10) * 0.06),
        height: gDeviceHeight * .10,

        top: collarTopOffset,
        // ((displayAreaHeight - (gDeviceHeight * .10)) / 2) -
        //     ((gDeviceHeight * .10) * 0.06),
        // top: ((displayAreaHeight -
        //             animatedBarbell.platesList[index].heightPlate) /
        //         2) -
        //     animatedBarbell.platesList[index].heightPlate * 0.06,
        ///
        ///
        ///
        right: (((gDumbbellDisplayAreaWidth - ironMasterHandleWidth) / 2)) +
            ironMasterHandleWidth +
            0, // +1 to account for Handle outline width from BoxDecoration border
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            color: animatedBarbell.barbellProperty.color,
            // color: animatedBarbell.widget.myStateInstance.barbellProperty.color,
          ),
          width: collarWidth,
          height: MediaQuery.of(context).size.height * .10, //collarHeight,
          // color: widget.color,
        ),
      ),
    );

    // Add the plates to the display list.
    // List<Widget> stackedPlates = [];
    double leftPlatesNextOffsetX = -4.0;
    double rightPlatesNextOffsetX = 7.0;

    // Iterate the _platesList objects and sets their target X position,
    // the plate objects are translated from an off-screen poistion using animation.
    //
    // Special Information:
    // This code is executed within the "build" context, so cannot call setState() here.
    // The plates positions are updated by the animation controller/tween outside the
    // build context.
    int lastAnimatedPlateIndex = 0;
    // int numberOfPlates = animatedBarbell.platesList.length;

    int plateCounter = 0;
    // double weightCurrent = 0;

    String platesDetailsText = ""; //"Add to each side: ";

    ///
    /// IRON MASTER - Add plates to the left side of the handle.
    ///
    for (var index = 0; index < animatedBarbell.platesList.length; index++) {
      // Calculate the targetXpoistions as the plates are loaded.
      if (animatedBarbell.platesList[index].name.contains("left")) {
        displayList.add(
          Positioned(
            height: animatedBarbell.platesList[index].heightPlate,
            top: ((displayAreaHeight -
                        animatedBarbell.platesList[index].heightPlate) /
                    2) -
                animatedBarbell.platesList[index].heightPlate * 0.06,
            // Set to targetXPosition
            // left: ironMasterHandleWidth * 1.2,
            right: leftPlatesNextOffsetX +
                ((gDumbbellDisplayAreaWidth - ironMasterHandleWidth) /
                    // ((MediaQuery.of(context).size.width - ironMasterHandleWidth) /
                    2) // Right collar position
                +
                ironMasterHandleWidth // Plus Handle Width
                +
                collarWidth +
                4, // Plus Collar Width + 4
            // + // Plus Lock Screw Width
            // left:
            // (ironMasterHandleWidth * 1.44) -
            //     // (ironMasterHandleWidth + 52) - // * 1.65) -
            //     animatedBarbell.platesList[index].widthPlate -
            //     leftPlatesNextOffsetX -
            //     0,
            // left: leftCollarEnd -
            //     animatedBarbell.platesList[index].widthPlate -
            //     leftPlatesNextOffsetX,
            child: animatedBarbell.platesList[index],
          ),
        );

        plateCounter++;

        // Detect whether the previous and current plate changed,
        // then reset the plateCounter to 1.
        if ( //index > 0 &&
            animatedBarbell.platesList[index].name !=
                animatedBarbell.platesList[lastAnimatedPlateIndex].name) {
          int plateCount = plateCounter - 1;
          platesDetailsText +=
              "(${plateCount.toStringAsFixed(1)} x ${animatedBarbell.platesList[lastAnimatedPlateIndex].realWeight.toStringAsFixed(1)}) + ";

          plateCounter = 1;
        }

        // Calculate offset for the next plate.
        leftPlatesNextOffsetX += animatedBarbell.platesList[index].widthPlate;

        /// Keep track of the last plate added to the barbell.
        lastAnimatedPlateIndex = index;
      }
    }

    //
    // Initialize totalPlatesWeight with user selected barbell weight.
    //
    double totalPlatesWeight = barbellWeight;
    for (WeightPlatesItemClass plate in theRack) {
      // If this plate size is used, then add to the details list.
      if (plate.usedCount > 0) {
        // Update total with plates weight multiplied by usedCount on each side of barbell (*2).

        // double formatedWeight = plate.weight * (2 * plate.usedCount);
        // double fraction = formatedWeight - formatedWeight.truncate();
        // if (fraction < 0.5) {
        //   totalPlatesWeight += formatedWeight.floor();
        // } else {
        //   totalPlatesWeight += formatedWeight.ceil();
        // }

        totalPlatesWeight += plate.weight * (2 * plate.usedCount);

        // ///
        // /// IRON MASTER - Get the User chosen 5lb real weight
        // ///
      }
    }
    totalPlatesWeight = (totalPlatesWeight).ceil().toDouble();

    ///
    /// Save to provider/notifier
    ///

    Provider.of<WeightRackBlocNotifier>(context, listen: false)
        .totalPlatesWeight = totalPlatesWeight;

    if (totalPlatesWeight > barbellWeight) {
      if (totalPlatesWeight == 10) {
        platesDetailsText += "(Lock Screw)";
      } else if (totalPlatesWeight > 10) {
        platesDetailsText += "(Lock Screw)";
        // platesDetailsText += "+ (Lock Screws)";
      }

      String addPlatesMessage = "Add to each side:";
      // String myDebugMessage = "";

      ///
      /// Add LEFT plates details
      ///
      Size textSizeTitle = _textSize(
        addPlatesMessage,
        TextStyle(fontSize: 12, color: Colors.black),
      );

      // myDebugMessage +=
      //     "collarHeight: " + collarHeight.toStringAsPrecision(6);
      // myDebugMessage += ", plateHeight: " +
      //     animatedBarbell.platesList[1].heightPlate
      //         .toStringAsPrecision(6);

      // myDebugMessage += "plateTop: " + plateTopOffeset.toStringAsPrecision(6);
      // myDebugMessage += ", collarTop: " + collarTopOffset.toStringAsPrecision(6);

      displayList.add(
        Positioned(
          top: 0,
          // left: 0,
          left: 0 + (gDeviceWidth - textSizeTitle.width) / 2,
          child: Text(
            addPlatesMessage,
            // myDebugMessage,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
      );

      Size textSizeWeights = _textSize(
        platesDetailsText,
        TextStyle(fontSize: 12, color: Colors.black),
      );

      displayList.add(
        Positioned(
            // top: textSizeTitle.height + 2,
            bottom: 0,
            // top: 0,
            left: 0 +
                (gDeviceWidth - textSizeWeights.width) /
                    2, // detailsTextOffset,
            // detailsTextOffset *
            //     Theme.of(context).primaryTextTheme.bodyText1.fontSize,
            child: Text(
              platesDetailsText,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            )),
      ); //positionedBarTypeStr);
    }

    ///
    /// IRON MASTER - Add plates to the right side of the handle.
    ///
    plateCounter = 0;
    lastAnimatedPlateIndex = 0;
    // weightCurrent = 0;
    for (var index = 0; index < animatedBarbell.platesList.length; index++) {
      // Calculate the targetXpoistions as the plates are loaded.
      if (animatedBarbell.platesList[index].name.contains("right")) {
        // weightCurrent = animatedBarbell.platesList[index].realWeight;

        // Calculate offset for the next plate.
        rightPlatesNextOffsetX += animatedBarbell.platesList[index].widthPlate;

        // double xOffset = 10-(index*2) as double;
        displayList.add(
          Positioned(
            height: animatedBarbell.platesList[index].heightPlate,
            top: ((displayAreaHeight -
                        animatedBarbell.platesList[index].heightPlate) /
                    2) -
                animatedBarbell.platesList[index].heightPlate * 0.06,
            right: ((gDumbbellDisplayAreaWidth - ironMasterHandleWidth) /
                    // ((MediaQuery.of(context).size.width - ironMasterHandleWidth) /
                    2) +
                collarWidth -
                rightPlatesNextOffsetX -
                0, //collarWidth,

            child: animatedBarbell.platesList[index],
          ),
        );

        plateCounter++;

        // Detect whether the previous and current plate changed,
        // then reset the plateCounter to 1.
        if ( //index > 0 &&
            animatedBarbell.platesList[index].name !=
                animatedBarbell.platesList[lastAnimatedPlateIndex].name) {
          // animatedBarbell.platesList[index].realWeight !=
          //     animatedBarbell.platesList[lastAnimatedPlateIndex].realWeight) {
          plateCounter = 1;
        }

        /// Keep track of the last plate added to the barbell.
        lastAnimatedPlateIndex = index;
      }
    }

    ///
    /// !!! This code below causes an error "setState() or markNeedsBuild() called during build."
    ///           from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
    /// FIXED:  By moving the assignment into this bloc business logic.
    ///
    /// Save the lastPlateIndex in the Provider, the loadbarbell view will use this
    /// to determine how to layout the plate updater widgtes plus/minus buttons.
    Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
        .lastAnimatedPlateIndex = lastAnimatedPlateIndex;
    if (animatedBarbell.platesList.isNotEmpty) {
      ///
      /// !!! This code below causes an error "setState() or markNeedsBuild() called during build."
      ///           from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
      /// FIXED:  By moving the assignment into this bloc business logic.
      ///
      Provider.of<BarbellDisplayListBlocNotifier>(
        context,
        listen: false,
      ).lastAnimatedPlateItem =
          animatedBarbell.platesList[lastAnimatedPlateIndex];

      if (lastAnimatedPlateIndex > 0) {
        // Get last plate that remains on the barbell
        Provider.of<BarbellDisplayListBlocNotifier>(
          context,
          listen: false,
        ).lastRemainingAnimatedPlateItem =
            animatedBarbell.platesList[lastAnimatedPlateIndex - 1];
      }

      // ///
      // /// Scale the barbell if the plates reached the end of barbell
      // ///
      // Positioned positionedWidget = _displayList.last;
      // if ( positionedWidget.left > MediaQuery.of(context).size.width * .90) {
      //   animatedBarbell.scale -= .05;
      // }
    }

    // Provider.of<BarbellDisplayListBlocNotifier>(context).changedPlates = true;
    _setSelectedWeightRackList(context, theRack);

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ///
    /// Create widget list of "details text under the barbell and plates image".
    /// This widget list is used in the build() function.
    ///
    animatedBarbell.platesUsedDetail.clear();

    bool showStrickthroughOn22lbPlate = true;

    bool show22lbPlatesCheckboxAndGraphics = false;
    // NEW 1/30/2025
    Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).show22lbPlatesCheckboxAndGraphics = false;

    ///
    /// IRON MASTER - Use the Heavy 22.5lb Plates if checkbox is selected.
    ///
    if (Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).isIronMasterDumbbellSet &&
        Provider.of<WeightRackBlocNotifier>(
              context,
              listen: false,
            ).dumbbellSet >=
            2) {
      // if (isTopLeftDumbbell == false) {
      showStrickthroughOn22lbPlate = Provider.of<WeightRackBlocNotifier>(
        context,
        listen: false,
      ).useHeavy22lbPlatesBottomRight;

      // NEW 1/30/2025
      Provider.of<WeightRackBlocNotifier>(
        context,
        listen: false,
      ).showStrickthroughOn22lbPlate = showStrickthroughOn22lbPlate;

      ///
      /// Init to false
      ///
      Provider.of<WeightRackBlocNotifier>(context, listen: false)
          .useHeavy22lbPlatesBottomRight = false;

      ///
      /// If the target weight "requires" the 22.5lb plates,
      /// then disable the 22.5lb Checkox.
      ///
      if (queriedWeight >= 55.0 && queriedWeight <= 75.0) {
        show22lbPlatesCheckboxAndGraphics = true;
        // NEW 1/30/2025
        Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).show22lbPlatesCheckboxAndGraphics = show22lbPlatesCheckboxAndGraphics;
      }

      ///
      /// If queriedWeight is greater than 75lb, then the 22lb plates
      /// are needed to reach desired weight.
      ///
      else if (queriedWeight > 75.0 &&
          // Mojeer is index 4
          Provider.of<WeightRackBlocNotifier>(context, listen: false)
              .isIronMasterDumbbellSet) {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .useHeavy22lbPlatesBottomRight = true;
      }
      // index 1 is 22.5lb plate by design
      // } else if (isTopLeftDumbbell == true) {
      //   showStrickthroughOn22lbPlate = Provider.of<WeightRackBlocNotifier>(
      //     context,
      //     listen: false,
      //   ).useHeavy22lbPlatesTopLeft;

      //   ///
      //   /// If the target weight "requires" the 22.5lb plates,
      //   /// then disable the 22.5lb Checkox.
      //   ///
      //   if (queriedWeight >= 55.0 && queriedWeight <= 75.0) {
      //     show22lbPlatesCheckboxAndGraphics = true;
      //   }

      //   ///
      //   /// If queriedWeight is greater than 75lb, then the 22lb plates
      //   /// are needed to reach desired weight.
      //   ///
      //   else if (queriedWeight > 75.0) {
      //     Provider.of<WeightRackBlocNotifier>(context, listen: false)
      //         .useHeavy22lbPlatesTopLeft = true;
      //   }
      // }
    }

    // NEW 1/30/2025 - Moved to loadbarbell_view.dart
    // animatedBarbell.platesUsedDetail.add(
    //   _columnLayoutOfLeftRightButtonAndWeightInfo(
    //     context,
    //     isTopLeftDumbbell,
    //     show22lbPlatesCheckboxAndGraphics,
    //     showStrickthroughOn22lbPlate,
    //     totalPlatesWeight,
    //   ),
    // );

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int listSize = displayList.length;
    if (kDebugMode) {
      print(
        'sizeof _displayList = $listSize ........................................................................................',
      );
    }

    // Update and notify listeners.

    ///
    /// This code below causes an error "setState() or markNeedsBuild() called during build."
    /// from flutter framework.dart:3880 inside markNeedsBuild() function.  !!!
    ///
    // Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
    //     .displayList = _displayList;
    ///
    /// IRON MASTER
    ///
    if (animatedBarbell.handleType ==
        // if (animatedBarbell.widget.handleType ==
        IronMasterHandleType.IRONMASTER_LEFT_HANDLE) {
      Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
          .displayList = displayList;
    } else {
      Provider.of<BarbellDisplayListBlocNotifier>(context, listen: false)
          .displayList2 = displayList;
    }

    // return theRack;
  }

//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   ///
//   ///   Function:  _columnLayoutOfLeftRightButtonAndWeightInfo
//   ///
//   /////////////////////////////////////////////////////////////////////////////////////////////////
//   Column _columnLayoutOfLeftRightButtonAndWeightInfo(
//     BuildContext context,
//     bool isTopLeftDumbbell,
//     bool show22lbPlatesCheckboxAndGraphics,
//     bool showStrickthroughOn22lbPlate,
//     double totalPlatesWeight,
//   ) {
//     final mediaQuery = MediaQuery.of(context);
//     final CommonSwitchClass metricSwitch = Provider.of<WeightRackBlocNotifier>(
//       context,
//       listen: false,
//     ).kiloPoundsSelectionSwitch;
//     return Column(
//       mainAxisAlignment: (Provider.of<WeightRackBlocNotifier>(
//                 context,
//                 listen: false,
//               ).dumbbellSet >=
//               2)
//           ? MainAxisAlignment.center //.spaceBetween //.end
//           : MainAxisAlignment.center,
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           // height: animatedBarbell.widget.barbellProperty.heightBarbell * 4,
//           height: gDumbbellDisplayAreaHeight *
//               .5, // Half the height of above display area
//           child: Stack(
//             // mainAxisAlignment:
//             //     (Provider.of<WeightRackBlocNotifier>(context, listen: false)
//             //                 .dumbbellSet >=
//             //             2)
//             //         ? MainAxisAlignment.spaceBetween //.end
//             //         : MainAxisAlignment.center,
//             children: <Widget>[
//               ///
//               /// Left Arrow Button
//               ///
//               // Positioned(
//               //   key: UniqueKey(),
//               //   left: mediaQuery.size.width * .05, //20,
//               //   // width: 36,
//               //   // height: 36,
//               //   child: IconButton(
//               //     iconSize: 36,
//               //     icon: Icon(Icons.arrow_back_ios),
//               //     color: Colors.blueAccent,
//               //     // onPressed: () {
//               //     onPressed: () async {
//               //       if (isTopLeftDumbbell == true) {
//               //         // Check and update Top or Left side dumbbells
//               //         if (gIronMasterTopViewWeightIndex > 0) {
//               //           gIronMasterTopViewWeightIndex--;
//               //           Provider.of<WeightRackBlocNotifier>(
//               //             context,
//               //             listen: false,
//               //           ).ironMasterTopViewWeightIndex =
//               //               gIronMasterTopViewWeightIndex;
//               //         }
//               //       } else {
//               //         // Check and update Bottom or Right side dumbbells
//               //         if (gIronMasterBottomViewWeightIndex > 0) {
//               //           gIronMasterBottomViewWeightIndex--;
//               //           Provider.of<WeightRackBlocNotifier>(
//               //             context,
//               //             listen: false,
//               //           ).ironMasterBottomViewWeightIndex =
//               //               gIronMasterBottomViewWeightIndex;
//               //         }
//               //       }
//               //     },
//               //   ),
//               // ),

//               /// Display the totalPlatesWeight value
//               // Positioned(
//               //   top: ((Provider.of<WeightRackBlocNotifier>(
//               //                 context,
//               //                 listen: false,
//               //               ).dumbbellSet >=
//               //               2) &&
//               //           (show22lbPlatesCheckboxAndGraphics == true))
//               //       ? 6
//               //       : 15, //displayAreaHeight * .5,
//               //   left: mediaQuery.size.width * .2, //60,
//               //   child: Container(
//               //     // width: MediaQuery.of(context).size.width,
//               //     width: mediaQuery.size.width * .6,
//               //     decoration: BoxDecoration(
//               //       ///
//               //       /// Add a border color around the plate to make it
//               //       /// more visible when plates are stacked next to each
//               //       /// other on the barbell.
//               //       ///
//               //       border: Border.all(
//               //         color: Color.fromRGBO(169, 113, 66, 1.0),
//               //       ),
//               //       // color: Colors.cyan),
//               //       color: Colors.transparent,
//               //     ),
//               //     // color: Colors.red,
//               //     child: Row(
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         Text(
//               //           (totalPlatesWeight).floor().toString(),
//               //           style: TextStyle(
//               //             color: Theme.of(context)
//               //                 .textSelectionTheme
//               //                 .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
//               //             fontSize: 14.0,
//               //             fontWeight: FontWeight.bold,
//               //           ),
//               //         ),

//               //         Text(
//               //           (metricSwitch.isSwitchedOn == false) ? "kg" : "lb",
//               //           style: TextStyle(
//               //             color: Theme.of(context)
//               //                 .textSelectionTheme
//               //                 .selectionColor, //.orangeAccent, //Theme.of(context).textSelectionColor, //Colors.black54,
//               //             fontSize: 16.0,
//               //             fontWeight: FontWeight.bold,
//               //           ),
//               //         ),

//               //         /// Add Padding when 22.5lb plates are used
//               //         ((Provider.of<WeightRackBlocNotifier>(
//               //                       context,
//               //                       listen: false,
//               //                     ).dumbbellSet >=
//               //                     2) &&
//               //                 (show22lbPlatesCheckboxAndGraphics == true))
//               //             ? Padding(padding: EdgeInsets.only(right: 24))
//               //             : Container(),

//               //         /// Add Checkbox Widget when 22.5lb plates are used.
//               //         ((Provider.of<WeightRackBlocNotifier>(
//               //                       context,
//               //                       listen: false,
//               //                     ).dumbbellSet >=
//               //                     2) &&
//               //                 (show22lbPlatesCheckboxAndGraphics == true))
//               //             ? SizedBox(
//               //                 height: 36,
//               //                 child:
//               //                     // (isTopLeftDumbbell == true)
//               //                     //     ? _displayTopLeftUse22lbCheckbox(context)
//               //                     //     :
//               //                     _displayBottomRightUse22lbCheckbox(
//               //                   context,
//               //                 ),
//               //               )
//               //             : Container(),

//               //         /// Display the 22.5lb rectangle widget
//               //         ((Provider.of<WeightRackBlocNotifier>(
//               //                       context,
//               //                       listen: false,
//               //                     ).dumbbellSet >=
//               //                     2) &&
//               //                 (show22lbPlatesCheckboxAndGraphics == true))
//               //             ? Stack(
//               //                 children: [
//               //                   Positioned(
//               //                     child: Container(
//               //                       // foregroundDecoration: StrikeThroughDecoration(),
//               //                       decoration: BoxDecoration(
//               //                         ///
//               //                         /// Add a border color around the plate to make it
//               //                         /// more visible when plates are stacked next to each
//               //                         /// other on the barbell.
//               //                         ///
//               //                         border: Border.all(
//               //                           color:
//               //                               Color.fromRGBO(169, 113, 66, 1.0),
//               //                         ),
//               //                         // color: Colors.cyan),
//               //                         color: Colors.black,
//               //                       ),
//               //                       width: MediaQuery.of(context).size.height *
//               //                           .10, //MediaQuery.of(context).size.width * .05,
//               //                       height: MediaQuery.of(context).size.width *
//               //                           .05, // MediaQuery.of(context).size.height * .10,
//               //                       child: Text(
//               //                         "22.5",
//               //                         // textScaleFactor: 0.75,
//               //                         textScaler:
//               //                             TextScaler.noScaling, // .linear(1),
//               //                         overflow: TextOverflow.clip,
//               //                         textAlign: TextAlign.center,
//               //                         // textDirection: TextDirection.LTR,
//               //                         style: DefaultTextStyle.of(
//               //                           context,
//               //                         ).style.apply(
//               //                               fontSizeFactor: 0.75,
//               //                               // (widget.widthPlate * 0.75) / widget.widthPlate,
//               //                               color: Colors.white,
//               //                             ),
//               //                         // textWidthBasis: TextWidthBasis.longestLine,
//               //                       ),
//               //                     ),
//               //                   ),
//               //                   (showStrickthroughOn22lbPlate == true)
//               //                       ? Positioned(child: Container())
//               //                       : Positioned(
//               //                           // left: ((MediaQuery.of(context).size.height * .10) -
//               //                           //         24) /
//               //                           //     2,
//               //                           // top: 2,
//               //                           child: Container(
//               //                             foregroundDecoration:
//               //                                 StrikeThroughDecoration(),
//               //                             width: MediaQuery.of(context)
//               //                                     .size
//               //                                     .height *
//               //                                 .10, //MediaQuery.of(context).size.width * .05,
//               //                             height: MediaQuery.of(context)
//               //                                     .size
//               //                                     .width *
//               //                                 .05, // MediaQuery.of(context).size.height * .10,
//               //                           ),
//               //                           // const Icon(
//               //                           //   Icons.not_interested,
//               //                           //   size: 16.0,
//               //                           //   color: Colors.deepOrangeAccent,
//               //                           // ),
//               //                         ),
//               //                 ],
//               //               )
//               //             : Container(),
//               //       ],
//               //     ),
//               //   ),
//               // ),

//               ///
//               /// Right Arrow Button
//               ///
// //               Positioned(
// //                 right: mediaQuery.size.width * .05, //20,
// //                 child: IconButton(
// //                   iconSize: 36,
// //                   icon: Icon(Icons.arrow_forward_ios),
// //                   color: Colors.blueAccent,
// //                   onPressed: () {
// //                     // if (isTopLeftDumbbell == true) {
// //                     //   // Check and update Top or Left side dumbbells
// //                     //   if (gIronMasterTopViewWeightIndex <
// //                     //       gIronMasterWeightMaxIndex - 1) {
// //                     //     gIronMasterTopViewWeightIndex++;
// //                     //     Provider.of<WeightRackBlocNotifier>(
// //                     //       context,
// //                     //       listen: false,
// //                     //     ).ironMasterTopViewWeightIndex =
// //                     //         gIronMasterTopViewWeightIndex;
// //                     //   }
// //                     // } else {
// //                     // Check and update Bottom or Right side dumbbells
// //                     if (gIronMasterBottomViewWeightIndex <
// //                         gIronMasterWeightMaxIndex - 1) {
// //                       gIronMasterBottomViewWeightIndex++;

// // //
// // // Exception has occurred.
// // // FlutterError (Looking up a deactivated widget's ancestor is unsafe.
// // // At this point the state of the widget's element tree is no longer stable.
// // // To safely refer to a widget's ancestor in its dispose() method,
// // // save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType()
// // // in the widget's didChangeDependencies() method.)

// //                       Provider.of<WeightRackBlocNotifier>(
// //                         context,
// //                         listen: false,
// //                       ).ironMasterBottomViewWeightIndex =
// //                           gIronMasterBottomViewWeightIndex;
// //                     }
// //                     // }

// //                     // int weight = _getIronMasterDumbbellSetValueAtIndex(context);
// //                     // print("weight = $weight");

// //                     // onSubmittedWeight2(weight.toString());
// //                   },
// //                 ),
// //               ),
//               // IconButton(icon: Icon(Icons.arrow_right_outlined), onPressed: () {}),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  List<WeightPlatesItemClass> _getSelectedWeightRackList(BuildContext context) {
    List<WeightPlatesItemClass> weightPlatesList;

    switch (Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).dumbbellSet) {
      case 0:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMaster45lbPlatesList;
        break;
      case 1:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMaster75lbPlatesList;
        break;
      case 2:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMaster120lbPlatesList;
        break;
      case 3:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMaster165lbPlatesList;
      case 4:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).moJeer40KgPlatesList;
        break;
      default:
        weightPlatesList = Provider.of<WeightRackBlocNotifier>(
          context,
          listen: false,
        ).ironMaster75lbPlatesList;
        break;
    }

    return weightPlatesList;

    // //
    // // Initialize the switch to toggle rack used, custom or standard.
    // //
    // CommonSwitchClass theSwitch =
    //     Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //         .weightRackSelectionSwitch;

    // CommonSwitchClass metricSwitch =
    //     Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //         .kiloPoundsSelectionSwitch;

    // List<WeightPlatesItemClass> weightPlatesList;

    // // Determine Standard or Custon rack
    // if (theSwitch.isSwitchedOn == true) {
    //   // Determine Kilo or Pounds metric
    //   if (metricSwitch.isSwitchedOn == true) {
    //     weightPlatesList =
    //         Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //             .weightPlatesStandardList;
    //   } else {
    //     weightPlatesList =
    //         Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //             .weightKiloPlatesStandardList;
    //   }
    // } else {
    //   // Determine Kilo or Pounds metric
    //   if (metricSwitch.isSwitchedOn == true) {
    //     weightPlatesList =
    //         Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //             .weightPlatesCustomList;
    //   } else {
    //     weightPlatesList =
    //         Provider.of<WeightRackBlocNotifier>(context, listen: false)
    //             .weightKiloPlatesCustomList;
    //   }
    // }

    // return weightPlatesList;
  }

  // Here it is!
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///   Function:  _setSelectedWeightRackList
  ///
  /////////////////////////////////////////////////////////////////////////////////////////////////
  void _setSelectedWeightRackList(
    BuildContext context,
    List<WeightPlatesItemClass> updatedRack,
  ) {
    //
    // Initialize the switch to toggle rack used, custom or standard.
    //
    CommonSwitchClass theSwitch = Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).weightRackSelectionSwitch;

    CommonSwitchClass metricSwitch = Provider.of<WeightRackBlocNotifier>(
      context,
      listen: false,
    ).kiloPoundsSelectionSwitch;

    // List<WeightPlatesItemClass> weightPlatesList;

    // Determine Standard or Custon rack
    if (theSwitch.isSwitchedOn == true) {
      // Determine Kilo or Pounds metric
      if (metricSwitch.isSwitchedOn == true) {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .weightPlatesStandardList = updatedRack;
      } else {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .weightKiloPlatesStandardList = updatedRack;
      }
    } else {
      // Determine Kilo or Pounds metric
      if (metricSwitch.isSwitchedOn == true) {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .weightPlatesCustomList = updatedRack;
      } else {
        Provider.of<WeightRackBlocNotifier>(context, listen: false)
            .weightKiloPlatesCustomList = updatedRack;
      }
    }
  }
}
