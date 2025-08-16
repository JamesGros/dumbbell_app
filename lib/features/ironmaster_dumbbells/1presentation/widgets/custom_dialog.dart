// import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'raisedgradientbutton.dart';

// class CustomDialog extends StatelessWidget {
//   final primaryColor = const Color(0xFF75A2EA);
//   final grayColor = const Color(0xFF939393);

//   final String title,
//       description,
//       primaryButtonText,
//       primaryButtonRoute,
//       secondaryButtonText,
//       secondaryButtonRoute;

//   final Function primaryCallbackFunction;
//   final Function secondaryCallbackFunction;

//   CustomDialog(
//       {@required this.title,
//       @required this.description,
//       @required this.primaryButtonText,
//       this.primaryButtonRoute,
//       this.secondaryButtonText,
//       this.secondaryButtonRoute,
//       this.primaryCallbackFunction,
//       this.secondaryCallbackFunction});

//   static const double padding = 20.0;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final newTextTheme = Theme.of(context).textTheme.apply(
//           bodyColor: Colors.white,
//           displayColor: Colors.white,
//         );
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(padding),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(padding),
//             decoration: BoxDecoration(
//                 color: Colors.white54, //Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(padding),
//                 gradient: LinearGradient(colors: <Color>[
//                   Colors.grey,
//                   Colors.grey[300],
//                   Colors.black54,
//                 ]),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 10.0,
//                     offset: const Offset(0.0, 10.0),
//                   ),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(height: 24.0),
//                 AutoSizeText(
//                   title,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                   style: newTextTheme.headline5,
//                   // style: TextStyle(
//                   //   color: Colors.white, //primaryColor,
//                   //   fontSize: 25.0,
//                   // ),
//                 ),
//                 (description != "") ? SizedBox(height: 24.0) : Container(),
//                 (description != "")
//                     ? AutoSizeText(
//                         description,
//                         maxLines: 4,
//                         textAlign: TextAlign.center,
//                         style: newTextTheme.headline6,
//                         // style: TextStyle(
//                         //   color: Colors.white, //grayColor,
//                         //   fontSize: 18.0,
//                         // ),
//                       )
//                     : Container(),
//                 SizedBox(height: 24.0),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: RaisedGradientButton(
//                         width: mediaQuery.size.width * .60,
//                         height: (mediaQuery.size.height -
//                                 mediaQuery.padding.top -
//                                 kToolbarHeight) *
//                             .06,
//                         gradient: LinearGradient(
//                             // begin: Alignment.centerRight,
//                             colors: <Color>[
//                               Colors.grey,
//                               Colors.grey[300],
//                               Colors.black54,
//                             ]),
//                         // ),
//                         text: primaryButtonText,
//                         onPressed: () {
//                           if (primaryCallbackFunction != null) {
//                             primaryCallbackFunction();
//                           } else {
//                             Navigator.of(context).pop();
//                             // Navigator.of(context)
//                             //     .pushReplacementNamed(primaryButtonRoute);
//                             if (primaryButtonRoute != null &&
//                                 primaryButtonRoute != "") {
//                               Navigator.of(context)
//                                   .pushNamed(primaryButtonRoute);
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 // RaisedButton(
//                 //   color: primaryColor,
//                 //   shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(30.0)),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 //     child: AutoSizeText(
//                 //       primaryButtonText,
//                 //       maxLines: 1,
//                 //       style: TextStyle(
//                 //         fontSize: 18,
//                 //         fontWeight: FontWeight.w200,
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //   ),
//                 //   onPressed: () {
//                 //     Navigator.of(context).pop();
//                 //     Navigator.of(context)
//                 //         .pushReplacementNamed(primaryButtonRoute);
//                 //   },
//                 // ),
//                 SizedBox(height: 10.0),
//                 showSecondaryButton(context),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   showSecondaryButton(BuildContext context) {
//     if (secondaryButtonRoute != null && secondaryButtonText != null) {
//       return TextButton(
//         child: AutoSizeText(
//           secondaryButtonText,
//           maxLines: 1,
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white, //primaryColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         onPressed: () {
//           if (secondaryCallbackFunction != null) {
//             secondaryCallbackFunction();
//           } else {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
//             // Navigator.of(context).pushNamed(secondaryButtonRoute);
//             if (secondaryButtonRoute != null && secondaryButtonRoute != "") {
//               Navigator.of(context).pushNamed(secondaryButtonRoute);
//             }
//           }
//         },
//       );
//     } else {
//       return SizedBox(height: 10.0);
//     }
//   }
// }

// class CustomAlertDialog extends StatelessWidget {
//   final primaryColor = const Color(0xFF75A2EA);
//   final grayColor = const Color(0xFF939393);
//   final Widget content;
//   final String
//       //title,
//       description,
//       primaryButtonText,
//       primaryButtonRoute,
//       secondaryButtonText,
//       secondaryButtonRoute;

//   final Function primaryCallbackFunction;
//   final Function secondaryCallbackFunction;

//   CustomAlertDialog(
//       {@required this.content,
//       // @required this.title,
//       @required this.description,
//       @required this.primaryButtonText,
//       this.primaryButtonRoute,
//       this.secondaryButtonText,
//       this.secondaryButtonRoute,
//       this.primaryCallbackFunction,
//       this.secondaryCallbackFunction});

//   static const double padding = 20.0;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(padding),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(padding),
//             decoration: BoxDecoration(
//                 color: Colors.white54, //Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(padding),
//                 gradient: LinearGradient(colors: <Color>[
//                   Colors.grey,
//                   Colors.grey[300],
//                   Colors.black54,
//                 ]),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 10.0,
//                     offset: const Offset(0.0, 10.0),
//                   ),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(height: 24.0),
//                 content,
//                 // AutoSizeText(
//                 //   title,
//                 //   maxLines: 2,
//                 //   textAlign: TextAlign.center,
//                 //   style: TextStyle(
//                 //     color: Colors.white, //primaryColor,
//                 //     fontSize: 25.0,
//                 //   ),
//                 // ),
//                 (description != "") ? SizedBox(height: 24.0) : Container(),
//                 (description != "")
//                     ? AutoSizeText(
//                         description,
//                         maxLines: 4,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white, //grayColor,
//                           fontSize: 18.0,
//                         ),
//                       )
//                     : Container(),
//                 SizedBox(height: 24.0),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: RaisedGradientButton(
//                         width: mediaQuery.size.width * .60,
//                         height: (mediaQuery.size.height -
//                                 mediaQuery.padding.top -
//                                 kToolbarHeight) *
//                             .06,
//                         gradient: LinearGradient(
//                             // begin: Alignment.centerRight,
//                             colors: <Color>[
//                               Colors.grey,
//                               Colors.grey[300],
//                               Colors.black54,
//                             ]),
//                         // ),
//                         text: primaryButtonText,
//                         onPressed: () {
//                           if (primaryCallbackFunction != null) {
//                             primaryCallbackFunction();
//                           } else {
//                             Navigator.of(context).pop();
//                             // Navigator.of(context)
//                             //     .pushReplacementNamed(primaryButtonRoute);
//                             if (primaryButtonRoute != null &&
//                                 primaryButtonRoute != "") {
//                               Navigator.of(context)
//                                   .pushNamed(primaryButtonRoute);
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 // RaisedButton(
//                 //   color: primaryColor,
//                 //   shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(30.0)),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 //     child: AutoSizeText(
//                 //       primaryButtonText,
//                 //       maxLines: 1,
//                 //       style: TextStyle(
//                 //         fontSize: 18,
//                 //         fontWeight: FontWeight.w200,
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //   ),
//                 //   onPressed: () {
//                 //     Navigator.of(context).pop();
//                 //     Navigator.of(context)
//                 //         .pushReplacementNamed(primaryButtonRoute);
//                 //   },
//                 // ),
//                 SizedBox(height: 10.0),
//                 showSecondaryButton(context),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   showSecondaryButton(BuildContext context) {
//     if (secondaryButtonRoute != null && secondaryButtonText != null) {
//       return TextButton(
//         child: AutoSizeText(
//           secondaryButtonText,
//           maxLines: 1,
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white, //primaryColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//           // Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
//           if (secondaryButtonRoute != null && secondaryButtonRoute != "") {
//             Navigator.of(context).pushNamed(secondaryButtonRoute);
//           }
//         },
//       );
//     } else {
//       return SizedBox(height: 10.0);
//     }
//   }
// }

// class CustomTrainingMaxDialog extends StatelessWidget {
//   final primaryColor = const Color(0xFF75A2EA);
//   final grayColor = const Color(0xFF939393);

//   final String title,
//       description,
//       primaryButtonText,
//       primaryButtonRoute,
//       secondaryButtonText,
//       secondaryButtonRoute;

//   final Widget detailsWidget;

//   final Function primaryCallbackFunction;
//   final Function secondaryCallbackFunction;

//   CustomTrainingMaxDialog(
//       {@required this.title,
//       @required this.description,
//       @required this.primaryButtonText,
//       this.primaryButtonRoute,
//       this.secondaryButtonText,
//       this.secondaryButtonRoute,
//       this.primaryCallbackFunction,
//       this.secondaryCallbackFunction,
//       this.detailsWidget});

//   static const double padding = 20.0;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final newTextTheme = Theme.of(context).textTheme.apply(
//           bodyColor: Colors.white,
//           displayColor: Colors.white,
//         );
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(padding),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             // height: mediaQuery.size.height * .50,
//             padding: EdgeInsets.all(padding),
//             decoration: BoxDecoration(
//                 color: Colors.white54, //Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(padding),
//                 gradient: LinearGradient(colors: <Color>[
//                   Colors.grey,
//                   Colors.grey[300],
//                   Colors.black54,
//                 ]),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 10.0,
//                     offset: const Offset(0.0, 10.0),
//                   ),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(height: 24.0),
//                 AutoSizeText(
//                   title,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                   style: newTextTheme.headline5,
//                   // style: TextStyle(
//                   //   color: Colors.white, //primaryColor,
//                   //   fontSize: 25.0,
//                   // ),
//                 ),
//                 // (description != "") ? SizedBox(height: 24.0) : Container(),
//                 // (description != "")
//                 //     ? AutoSizeText(
//                 //         description,
//                 //         maxLines: 4,
//                 //         textAlign: TextAlign.center,
//                 //         style: newTextTheme.headline6,
//                 //         // style: TextStyle(
//                 //         //   color: Colors.white, //grayColor,
//                 //         //   fontSize: 18.0,
//                 //         // ),
//                 //       )
//                 //     : Container(),
//                 detailsWidget,
//                 SizedBox(height: 24.0),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: RaisedGradientButton(
//                         width: mediaQuery.size.width * .60,
//                         height: (mediaQuery.size.height -
//                                 mediaQuery.padding.top -
//                                 kToolbarHeight) *
//                             .06,
//                         gradient: LinearGradient(
//                             // begin: Alignment.centerRight,
//                             colors: <Color>[
//                               Colors.grey,
//                               Colors.grey[300],
//                               Colors.black54,
//                             ]),
//                         // ),
//                         text: primaryButtonText,
//                         onPressed: () {
//                           if (primaryCallbackFunction != null) {
//                             primaryCallbackFunction();
//                           } else {
//                             Navigator.of(context).pop();
//                             // Navigator.of(context)
//                             //     .pushReplacementNamed(primaryButtonRoute);
//                             if (primaryButtonRoute != null &&
//                                 primaryButtonRoute != "") {
//                               Navigator.of(context)
//                                   .pushNamed(primaryButtonRoute);
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 10.0),
//                 // showSecondaryButton(context),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // showSecondaryButton(BuildContext context) {
//   //   if (secondaryButtonRoute != null && secondaryButtonText != null) {
//   //     return TextButton(
//   //       child: AutoSizeText(
//   //         secondaryButtonText,
//   //         maxLines: 1,
//   //         style: TextStyle(
//   //           fontSize: 18,
//   //           color: Colors.white, //primaryColor,
//   //           fontWeight: FontWeight.w400,
//   //         ),
//   //       ),
//   //       onPressed: () {
//   //         if (secondaryCallbackFunction != null) {
//   //           secondaryCallbackFunction();
//   //         } else {
//   //           Navigator.of(context).pop();
//   //           // Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
//   //           // Navigator.of(context).pushNamed(secondaryButtonRoute);
//   //           if (secondaryButtonRoute != null && secondaryButtonRoute != "") {
//   //             Navigator.of(context).pushNamed(secondaryButtonRoute);
//   //           }
//   //         }
//   //       },
//   //     );
//   //   } else {
//   //     return SizedBox(height: 10.0);
//   //   }
//   // }
// }
