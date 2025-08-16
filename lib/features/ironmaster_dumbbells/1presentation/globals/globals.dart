import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/60068435/what-is-null-safety-in-dart

///
/// Change this flag to enable the Dumbell View feature that displays
/// Double or Single dumbell view.
///
bool gEnableDoubleDumbbellView = false;

///
/// IRON MASTER - Initialize these in main.dart
///
double gDeviceWidth = 0.0;
double gDeviceHeight = 0.0;
// To get height just of SafeArea (for iOS 11 and above):
double gDeviceNewHeight = 0.0;
double gDumbbellContainerAreaHeight = 0.0;
double gDumbbellDisplayAreaHeight = 0.0;
double gDumbbellDisplayAreaRotatedHeight =
    0.0; // When rotated, width is the height used to calc postioning
double gDeviceNewRotatedHeight = 0.0;
double gDumbbellDisplayAreaWidth = 0.0;
double gBarbellHeight = 0.0;

int gIronMasterWeightMaxIndex = 0;
int gIronMasterTopViewWeightIndex = 0;
int gIronMasterBottomViewWeightIndex = 0;
bool gRedrawTopDumbbellView = false;

///
/// The animated plate height percentage of device height
///
const double gPlateHeightPercent = 0.09;

///
/// The detailed text in silver box - percentage of device height
///
const double gFontSizePercent = .018;

///
/// This is set at runtime in main()
///
bool giSiPadDevice = false;

List<Color> gLightBackgroundGradientColors = [
  Color(0xFFaaaaaa), Color(0xFFeeeeee)
  // Color(0xFFeeeeee), Color(0xFFbbbbbb)
  //Colors.white,
  //Colors.white
// Colors.orange[100]
];

///
/// This is initialized inside the home page when the AppBar
/// is created.
///
double gAppBarHeight = 56; // Default - Updated in Home Page at runtime
double gStatusBarHeight = 20; // Default - Updated in Home Page at runtime

///
/// Experiment with loading plates starting with what plates are already loaded.
///
bool gUnRackCurrentPlates = false;

/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
///
/// Android Build Command from Terminal:
///
/// > flutter build appbundle
///
/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
///
/// AdMob account with:  BarbellNote@gmail.com (Carnitine00)
///
/// Firebase account with:  jameshgros@gmail.com (barbellNotebook00)
///
/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
