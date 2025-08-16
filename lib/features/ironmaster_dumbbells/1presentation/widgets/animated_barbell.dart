// import 'dart:math';

// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/globals/globals.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/models/weightplate_model.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/barbelldisplaylist_notifier.dart';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/notifiers/weightrack_notifier.dart';

class BarbellProperty {
  Color color = Colors.white;
  double widthBarbell = 10.0;
  double heightBarbell = 5.0;
  double desiredWeight = 5.0;
  double displayViewWidth = 10.0;
  double displayViewHeight = 5.0;
}

enum IronMasterHandleType { IRONMASTER_LEFT_HANDLE, IRONMASTER_RIGHT_HANDLE }

class AnimatedBarbell extends StatefulWidget {
  AnimatedBarbellState myStateInstance = AnimatedBarbellState();

  AnimatedBarbell({
    super.key,
    // required this.ironMasterHandle,
  });

  // IRON MASTER - The 2nd dunbell
  // AnimatedBarbellState myStateInstance2;

  // AnimatedBarbell() {

  // }

  @override
  AnimatedBarbellState createState() => AnimatedBarbellState();
  // AnimatedBarbellState createState() {
  //   ///
  //   /// Save this Stateful widget's _MyState instance to be used
  //   /// in the weightrack_bloc event handlers.
  //   ///
  //   myStateInstance = AnimatedBarbellState();
  //   return myStateInstance;
  // }
}

class AnimatedBarbellState extends State<AnimatedBarbell>
    with SingleTickerProviderStateMixin {
  BarbellProperty barbellProperty = BarbellProperty();
  BarbellProperty get getBarbellProperty => barbellProperty;

  IronMasterHandleType ironMasterHandle =
      IronMasterHandleType.IRONMASTER_LEFT_HANDLE;
  IronMasterHandleType get handleType => ironMasterHandle;

  set handleType(IronMasterHandleType data) {
    ironMasterHandle = data;
  }

  // AnimatedBarbellState() {
  //   widget.myStateInstance = this;
  // }

  // IronMasterHandleType _handleType;

  // IronMasterHandleType get handleType => widget.myStateInstance.handleType;
  // setter
  // setHandleType(IronMasterHandleType data) {
  //   widget.myStateInstance.handleType = data;
  // }

  // static const myStateInstance = this;

  // Inside this objects build() method, use a Row Widget children[] as
  // (children: [Widget1, Widget2, Widget3,...])
  //
  // Create a display list that will visually show:
  //
  //     platesList[0], ..., platesList[n], _barbell, platesList[0], ..., platesList[n]
  //

  // A list of plates loaded on the barbell, this is iterated to calculate the positions of the left/right plates
  // that are loaded on the barbell.
  //
  // This list is persistent and needs a getter so that the rack selection switch or barbell checkboxes
  // can trigger the load/unload plate animation
  List<AnimatedPlate> platesList = [];

  //
  // Special Information:
  // This instance of theBarbell (AnimatedBarbell) is initialized in the WeightrackBloc logic.
  //
  // This was done so that when the barbell type has a weight of 15lb, 15lb, or 45lb, the
  // the barbell width and height can be dynamically changed if the AppUser changes the
  // barbell type.  The barbell dimensions are used to calculate the plate positioning on the
  // barbell that is drawn on the screen.
  late Widget theBarbell;

  double scale = 1.0;

  late AnimationController controllerAngle;

  // The final list of displayed objects:
  //
  //   [AnimatedBarbell, AnimatedPlate, AnimatedPlate, AnimatedPlate, AnimatedPlate] etc.
  //
  //   [barbell, leftPlate1, leftPlate2, rightPlate1, rightPlate2] etc.
  //
  // Special Information:
  // 1.  The barbell widget is always the first item on the display list.
  // 2.  The AnimatedPlate widgets are childrened to the flutter's AnimatedContainer() widget
  //     to allow it to be animated by the flutter's AnimationController() widget
  //     and the Tween<Offset> widget.
  // List<Widget> _displayList = [];
  List<Widget> displayList =
      []; // Initialize this in the init function because context is needed.
  static bool initializedPlatesList = false;

  // getter for platesList
  // List<AnimatedPlate> get platesList => platesList;

  // Displays the total weight loaded on the barbell.
  List<Widget> platesUsedDetail = [];

  ///
  /// _spawnPoundsPlates
  ///
  void spawnPoundsPlates(
    BuildContext context,
    List<WeightPlatesItemClass> weightPlatesList,
  ) {
    ///
    /// The MediaQuery.of(context).size.height value is different depending on context?
    /// i.e., Debug vs Release build the MediaQuery.of(context).size.height value changes!!!
    ///
    gDeviceHeight = MediaQuery.of(context).size.height;

    ///
    ///
    ///
    for (var index = 0; index < weightPlatesList.length; index++) {
      switch (weightPlatesList[index].name) {
        case "22.5lb":
          if (weightPlatesList[index].usedCount > 0) {
            for (var plateCount = 0;
                plateCount < weightPlatesList[index].usedCount;
                plateCount++) {
              platesList.add(
                AnimatedPlate(
                  name: "left22.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.blueGrey,
                  widthPlate: MediaQuery.of(context).size.width * .05, //
                  // widthPlate: 17,
                  // heightPlate: 50,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: -45,
                ),
              );
              platesList.add(
                AnimatedPlate(
                  name: "right22.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.blueGrey,
                  widthPlate: MediaQuery.of(context).size.width * .05, //17,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: 500,
                ),
              );
            }
          }
          break;
        case "5lb":
          if (weightPlatesList[index].usedCount > 0) {
            for (var plateCount = 0;
                plateCount < weightPlatesList[index].usedCount;
                plateCount++) {
              platesList.add(
                AnimatedPlate(
                  name: "left5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.blueGrey,
                  widthPlate: MediaQuery.of(context).size.width * .04, //
                  // widthPlate: 17,
                  // heightPlate: 50,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: -45,
                ),
              );
              platesList.add(
                AnimatedPlate(
                  name: "right5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.blueGrey,
                  widthPlate: MediaQuery.of(context).size.width * .04, //17,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: 500,
                ),
              );
            }
          }
          break;
        case "2.5lb": // this is 2.5 - 2 equals floor of 2.5
          if (weightPlatesList[index].usedCount > 0) {
            for (var plateCount = 0;
                plateCount < weightPlatesList[index].usedCount;
                plateCount++) {
              platesList.add(
                AnimatedPlate(
                  name: "left2.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.yellow,
                  widthPlate: MediaQuery.of(context).size.width * .03, //10,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: -45,
                ),
              );
              platesList.add(
                AnimatedPlate(
                  name: "right2.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.yellow,
                  widthPlate: MediaQuery.of(context).size.width * .03, //10,
                  heightPlate: MediaQuery.of(context).size.height * .10,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: 500,
                ),
              );
            }
          }
          break;
        case "LockScrew2.5lb": // this is 2.5 - 2 equals floor of 2.5
          if (weightPlatesList[index].usedCount > 0) {
            for (var plateCount = 0;
                plateCount < weightPlatesList[index].usedCount;
                plateCount++) {
              platesList.add(
                AnimatedPlate(
                  name: "leftLockScrew2.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.yellow,
                  widthPlate: MediaQuery.of(context).size.width * .03, //10,
                  heightPlate: MediaQuery.of(context).size.height * .07, //.06,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: -45,
                ),
              );
              platesList.add(
                AnimatedPlate(
                  name: "rightLockScrew2.5lb",
                  colorPlate: weightPlatesList[index].color, //Colors.yellow,
                  widthPlate: MediaQuery.of(context).size.width * .03, //10,
                  heightPlate: MediaQuery.of(context).size.height * .07, //.06,
                  realWeight: weightPlatesList[index].weight,
                  // off-screen position
                  targetXPosition: 500,
                ),
              );
            }
          }
          break;

        default:
          break;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  /// _addPoundsPlate
  ///
  ////////////////////////////////////////////////////////////////////////////////////////////////
  void addPoundsPlate(List<WeightPlatesItemClass> weightPlatesList) {
    // for (var index = 0; index < _weightPlatesList.length; index++) {
    for (WeightPlatesItemClass plate in weightPlatesList) {
      if (plate.plateAdded == true) {
        plate.plateAdded = false; // Reset flag.
        switch (plate.name) {
          case "22.5lb":
            platesList.add(
              AnimatedPlate(
                name: "left22.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .04, //17,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: -45,
              ),
            );
            platesList.add(
              AnimatedPlate(
                name: "right22.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .04, //17,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: 500,
              ),
            );
            break;
          case "5lb":
            platesList.add(
              AnimatedPlate(
                name: "left5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //17,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: -45,
              ),
            );
            platesList.add(
              AnimatedPlate(
                name: "right5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //17,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: 500,
              ),
            );
            break;
          case "2.5lb":
            platesList.add(
              AnimatedPlate(
                name: "left2.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //10,
                heightPlate: 100,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: -45,
              ),
            );
            platesList.add(
              AnimatedPlate(
                name: "right2.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //10,
                heightPlate: 100,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: 500,
              ),
            );
            break;
          case "LockScrew2.5lb":
            platesList.add(
              AnimatedPlate(
                name: "leftLockScrew2.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //10,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: -45,
              ),
            );
            platesList.add(
              AnimatedPlate(
                name: "rightLockScrew2.5lb",
                colorPlate: plate.color, //Colors.cyan,
                widthPlate: gDeviceWidth * .03, //10,
                heightPlate: 50,
                realWeight: plate.weight,
                // off-screen position
                targetXPosition: 500,
              ),
            );
            break;
          default:
            break;
        }
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  /// _removePoundsPlate
  ///
  ////////////////////////////////////////////////////////////////////////////////////////////////
  void removePoundsPlate(List<WeightPlatesItemClass> weightPlatesList) {
    // for (var index = 0; index < _weightPlatesList.length; index++) {
    for (WeightPlatesItemClass plate in weightPlatesList) {
      if (plate.plateRemoved == true) {
        plate.plateRemoved = false; // Reset flag.

        ///
        /// TODO:  Fix this sync bug, the usedCount should never equal zero
        ///        if platedRemoved flag was set to true!
        ///
        ///        Redesign to use BLOC pattern instead of Provider/Notifier pattern.
        ///
        if (platesList.isNotEmpty) {
          platesList.removeLast();
          platesList.removeLast();
        }
      }
    }
  }

  @override
  void initState() {
    // widget.myState = this;

    controllerAngle = AnimationController(
      reverseDuration: const Duration(milliseconds: 960),
      duration: const Duration(milliseconds: 480),
      vsync: this,
    );
    // ..addStatusListener((state) => print('ANGLE ANGLE State..... $state'));

    controllerAngle.forward();

    super.initState();
  }

  // double _getCollarDistance() {
  //   return widget.widthBarbell * 0.45;
  // }

  @override
  void dispose() {
    displayList.clear();

    platesList.clear();

    platesUsedDetail.clear();

    initializedPlatesList = false;

    controllerAngle.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///
    /// Get the barbellText - the barbell currently selected in the LBV.
    ///
    // String barbellText = getCurrentBarbellTypeString(
    //   Provider.of<LoadBarbellBlocNotifier>(context, listen: true).barbellInUse,
    // );

    List<Widget> barbellWithPlatesDisplayList = [];

    ///
    /// IRON MASTER - displayLis1 is for LEFT dunbbell
    ///              displayList2 is for RIGHT dumbbell
    ///
    if (widget.myStateInstance.handleType ==
        IronMasterHandleType.IRONMASTER_LEFT_HANDLE) {
      for (Widget widgetItem in Provider.of<BarbellDisplayListBlocNotifier>(
        context,
        listen: true,
      ).displayList) {
        barbellWithPlatesDisplayList.add(widgetItem);
      }
    } else {
      for (Widget widgetItem in Provider.of<BarbellDisplayListBlocNotifier>(
        context,
        listen: true,
      ).displayList2) {
        barbellWithPlatesDisplayList.add(widgetItem);
      }
    }

    // barbellWithPlatesDisplayList.add(Positioned(
    //     left: -300,
    //     width: 30,
    //     child: Padding(
    //       padding: EdgeInsets.only(right: 40.0),
    //       child: Container(
    //         color: Colors.blue,
    //       ),
    //     )));

    widget.myStateInstance.barbellProperty.displayViewWidth =
        widget.myStateInstance.barbellProperty.widthBarbell;
    barbellProperty.displayViewHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            kToolbarHeight) *
        .16;

    // if (widget.)

    return Container(
      // key: widget.myUniqueKey,
      // transform: Matrix4.identity()..translate(-100, 0, 0),
      // transform: Matrix4.translationValues(0, 0, 0), //.rotationZ((40 * (pi / 180))),
      // duration: Duration(milliseconds: 960),
      ///
      /// The height of this Container is larger than the height
      /// of the AnimatedContainer child below.  This fixes the
      /// "A RenderFlex overflowed by 6.2 pixels on the bottom." error.
      height: gDumbbellContainerAreaHeight,
      // (MediaQuery.of(context).size.height -
      //         MediaQuery.of(context).padding.top -
      //         kToolbarHeight) *
      //     .18, // Larger than the height of AnimatedContainer of ".15"
      width: widget.myStateInstance.barbellProperty
          .widthBarbell, // + 200, // + ((scale == 1.0)?0:(100)),
      // width: MediaQuery.of(context).size.width - 40,
      // color: Colors.orange,
      color: Colors.transparent, //Colors.orange,
      // alignment: Alignment.center, // where to position the child
      alignment: Alignment.topCenter, // where to position the child
      child: AnimatedContainer(
        // transform: Matrix4.identity()..translate(-100, 0, 0),
        transform: Matrix4.translationValues(
          0,
          0,
          0,
        ), //.rotationZ((40 * (pi / 180))),
        duration: Duration(milliseconds: 480),
        height: gDumbbellDisplayAreaHeight,
        // height: gDumbbellDisplayAreaHeight - 5,
        width: widget.myStateInstance.barbellProperty
            .widthBarbell, // + 200, // + ((scale == 1.0)?0:(100)),
        ///
        /// Use the BoxDecoration with metal image instead of color.
        ///
        // color: Colors.orange,
        // foregroundDecoration: ,
        decoration: BoxDecoration(
          // color: Colors.blue,
          image: DecorationImage(
            image: AssetImage(
                "lib/features/ironmaster_dumbbells/assets/Pngtree_shiny_metal-small.jpg"),
            fit: BoxFit.cover, // .fitWidth, //.cover,
          ),
        ),
        alignment: Alignment.center, // where to position the child
        child:

            ///
            /// This is a experimental rotation code for using on the total weight and reps volume display
            ///
            // Transform(
            //   child:
            //   Stack(
            //       children: barbellWithPlatesDisplayList),
            //   alignment: FractionalOffset.bottomCenter, // .bottomRight,
            //   transform: new Matrix4.identity()
            //     ..rotateZ(_offsetFloatAngle.value * 3.1415927 / 180),
            // ),
            Transform.scale(
          scale: scale, //1.0,
          child: Stack(
            alignment: Alignment.center,
            // The Row's children should be (children: [Widget1, Widget2, Widget3,...])
            // Create a display list of [_barbell, platesList[0], ..., platesList[n]]
            children: barbellWithPlatesDisplayList,
          ),
        ),
      ),
    );
  }
} // End of _AnimatedBarbellState

class AnimatedPlate extends StatefulWidget {
  // Name used for the state machine instance.
  final String name;
  final Color colorPlate;
  final double widthPlate;
  double heightPlate;
  final double
      realWeight; // Used by loadbarbell view for id'ing last loaded plate.
  final double targetXPosition;

  AnimatedPlate({
    super.key,
    required this.name,
    required this.colorPlate,
    required this.widthPlate,
    required this.heightPlate,
    required this.realWeight,
    required this.targetXPosition,
  });

  // @override
  // AnimatedPlateState createState() => AnimatedPlateState();

  @override
  AnimatedPlateState createState() => AnimatedPlateState(
        name: name,
        color: colorPlate,
        width: widthPlate,
        height: heightPlate,
        realWeight: realWeight,
        targetXPosition: targetXPosition,
      );
}

class AnimatedPlateState extends State<AnimatedPlate>
    with SingleTickerProviderStateMixin {
  String name;
  Color color;
  double width;
  double height;
  double realWeight;
  double targetXPosition;

  // Constuctor
  AnimatedPlateState({
    required this.name,
    required this.color,
    required this.width,
    required this.height,
    required this.realWeight,
    required this.targetXPosition,
  }) {
    name = name;
    color = color;
    width = width;
    height = 10;
    // this.height = height;
    realWeight = realWeight;
    targetXPosition = targetXPosition;
  }

  late AnimationController controller;

  // Animation offset start and end.
  double offsetStart = 0.0;
  double offsetEnd = 0.0;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Init plate starting position.
    if (widget.name.contains("right")) {
      // Position off screen.
      offsetStart = 2000;
      //MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    } else {
      offsetStart = -2000;
    }
    // Set up animation controller.
    controller = AnimationController(
      // duration: const Duration(milliseconds: 1980), vsync: this);
      duration: const Duration(milliseconds: 480),
      vsync: this,
    );

    // Start the animation, the plates were positioned off-screen and
    // will animate to on-screen position simulating installation of the plates
    // on the barbell.
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (widget.name.contains("Screw") == false)
          ? BoxDecoration(
              ///
              /// Add a border color around the plate to make it
              /// more visible when plates are stacked next to each
              /// other on the barbell.
              ///
              border: (widget.colorPlate == Colors.black)
                  ? Border.all(color: Color.fromRGBO(169, 113, 66, 1.0))
                  //Colors.white)
                  : Border.all(color: Colors.black),
              // color: Colors.cyan),
              color: widget.colorPlate,
            )
          :

          ///
          /// Use the knurl image as the screw lock.
          ///
          BoxDecoration(
              border: Border.all(width: 1),
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                    "lib/features/ironmaster_dumbbells/assets/knurl-surface-small.jpg"),
                fit: BoxFit.fill,
              ),
            ),
      width: widget.widthPlate,
      height: widget.heightPlate,
      child: (widget.name.contains("Screw") == true)
          ? Container()
          : RotatedBox(
              quarterTurns: 1,
              child: Text(
                // widget.realWeight.toString(),
                ///
                /// Apply users 5lb weight correction
                ///
                (widget.realWeight == 5.0)
                    ? Provider.of<WeightRackBlocNotifier>(
                        context,
                        listen: true,
                      ).weightCorrectionValue.toStringAsFixed(1)
                    : widget.realWeight.toStringAsFixed(1),

                // textScaleFactor: 0.75,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                // textDirection: TextDirection.LTR,
                style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor:
                          (widget.name.contains("22.5")) ? 0.75 : 0.70,
                      // (widget.widthPlate * 0.75) / widget.widthPlate,
                      color: Colors.white,
                    ),
                // textWidthBasis: TextWidthBasis.longestLine,
              ), //"10"),
            ),
    );
  }
}
